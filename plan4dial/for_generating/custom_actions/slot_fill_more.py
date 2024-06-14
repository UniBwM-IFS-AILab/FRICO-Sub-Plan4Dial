"""Contains all the functions for the
:py:func:`slot_fill <plan4dial.for_generating.custom_actions.slot_fill.slot_fill>`
custom action that is provided to bot designers by default.

Authors:
- Rebecca De Venezia
"""

from typing import List, Dict, Tuple
import itertools
from .utils import map_assignment_update, make_additional_updates
from ..parsers.json_config_parser import configure_assignments

from .slot_fill import _clarify_act, _create_clarifications_single_slots

import copy 

def slot_fill_more(
    loaded_yaml: Dict,
    message_variants : List[str],
    condition: Dict = None,
    effect: Dict = None,

) -> None:
   
    action = {}
    action["type"] = "dialogue"
    action["message_variants"] = message_variants
    action["condition"] = condition
    action["effect"] = {"validate-slot-fill-more": {"oneof":{"outcomes":{}}}}
    
    outcomes = effect[list(effect.keys())[0]]["oneof"]["outcomes"]
    print("I am here")
    for outcome_name, outcome_config in outcomes.items(): 
        
        
        
        additional_updates = None if not "additional_updates" in outcome_config.keys() else outcome_config["additional_updates"]
        additional_conditions = None if not "additional_conditions" in outcome_config.keys() else outcome_config["additional_conditions"]
        updates_filtered = {}
        non_entities_updates = {}
    
        additional_updates_copy = copy.deepcopy(additional_updates)
        
        entities = outcome_config["entities"]
        overall_intent = outcome_config["overall_intent"]
        config_entities = outcome_config["config_entities"]
        action_name = outcome_name
        if additional_updates:
            # iterate through all additional updates
            for i in range(len(additional_updates)):
                # iterate through each context variable detailed in the outcome
                for var in additional_updates[i]["outcome"]:
                    # convert to an assignment setting so we can more easily identify what
                    # outcome we're referring to
                    additional_updates[i]["outcome"][var] = configure_assignments(
                        additional_updates[i]["outcome"][var]["known"]
                    )
                if list(additional_updates[i]["outcome"].keys())[0] not in config_entities.keys(): 
                
                    non_entities_updates.update(additional_updates_copy[i]) # this is ugly but it should work 
                # we don't want to consider when entities are NOT found because 1) it's a
                # lot more ambiguous and 2) when extracting entities, we only have
                # knowledge of what we DID extract and not what we DIDN'T. (yes, we could
                # figure it out by looking at the available outcome groups, but it's just
                # more overhead for what seems like an edge case - specifying additional
                # updates when updates ARE extracted is just a lot more intuitive).

                # frozenset is an easy way to see at a glance the assignment setting of
                # each (known/maybe known) context variable
                out = frozenset(
                    {
                        entity: certainty
                        for entity, certainty in additional_updates[i]["outcome"].items()
                        if certainty != "didnt-find"
                    }.items()
                )
                # don't need outcome so remove it
                del additional_updates[i]["outcome"]
                updates_filtered[out] = additional_updates[i]
        entity_combos = []
        for entity in entities:
            entity_combos.append(
                [
                    p
                    for p in itertools.product(
                        [entity],
                        (
                            ["found", "maybe-found", "didnt-find"]
                            if loaded_yaml["context_variables"][entity]["known"]["type"]
                            == "fflag"
                            else ["found", "didnt-find"]
                        ),
                    )
                ]
            )
        
        entity_combos = itertools.product(*entity_combos)    
        
        for combo in entity_combos:
        # refine combo by exluding "didnt-find" which we don't need for updates
            refined_combo = {
                entity: certainty
                for entity, certainty in combo
                if certainty != "didnt-find"
            }
            # only consider outcomes in which we find at least something
            if refined_combo:
                next_out = {"updates": {}}
                # store the intent based on the refined combo.
                # if we are only extracting one entity of multiple, use the intent for
                # just that entity; otherwise use the "overarching" intent
                outcome_name = "".join(
                    f"{entity}_{certainty}-" for entity, certainty in refined_combo.items()
                )[:-1]
                if len(refined_combo) == 1 and len(entities) > 1:
                    single_slot_int = config_entities[list(refined_combo.keys())[0]][
                        "single_slot_intent"
                    ]
                    if list(refined_combo.values())[0] == "maybe-found":
                        next_out["intent_cfg"] = f"{single_slot_int}__{outcome_name}"
                    next_out["intent"] = single_slot_int
                else:
                    # make intent name more specific to avoid duplicate intent names
                    if list(refined_combo.values()) != [
                        "found" for _ in range(len(entities))
                    ]:
                        next_out["intent_cfg"] = f"{overall_intent}__{outcome_name}"
                    next_out["intent"] = overall_intent
                # add the updates based on what's in this refined combo (again, ignoring
                # what we didn't find)
                for entity, certainty in refined_combo.items():
                    next_out["updates"].update(map_assignment_update(entity, certainty))

                if additional_updates:
                    # convert the current outcome into a frozenset to be compared
                    key = frozenset(refined_combo.items())
                    # check if this frozenset is included in the dict of outcomes with
                    # additional updates; if so, add the appropriate updates
                    if key in updates_filtered:
                        make_additional_updates(next_out, updates_filtered[key])
            
                if non_entities_updates: 
                    if all([c[1] == "found" for c in combo]): 
                        for k, v in non_entities_updates.items(): 
                            print(v)
                            next_out['updates'].update(v)
            action["effect"]["validate-slot-fill-more"]["oneof"]["outcomes"][
                outcome_name
            ] = next_out
        #actions = {f"slot-filler__subaction_{action_name}": action}
        # create clarifications and single slot actions as necessary
        new_actions, new_ctx_vars = _create_clarifications_single_slots(
            action_name,
            action,
            entities,
            config_entities,
            loaded_yaml["context_variables"],
            updates_filtered,
            non_entities_updates
        )
        #actions.update(new_actions)
        loaded_yaml["actions"].update(new_actions)
        loaded_yaml["context_variables"].update(new_ctx_vars)
        
        # loaded_yaml = loaded_yaml
        # actions_name = outcome_name
        # message_variants = message_variants
        # entities = outcome_config["entities"]
        # overall_intent = outcome_config["overall_intent"]
        # config_entites = outcome_config["config_entities"]
        # fallback_message_variants = None if not "fallback_message_variants" in outcome_config.keys() else outcome_config["fallback_message_variants"]
        # additional_conditions = None if not "additional_conditions" in outcome_config.keys() else outcome_config["additional_conditions"]
        # additional_updates = None if not "additional_updates" in outcome_config.keys() else outcome_config["additional_updates"]
        
        

        
        
        # slot_fill(loaded_yaml= loaded_yaml,
        #           action_name= actions_name, 
        #           message_variants=message_variants, 
        #           entities= entities,
        #           overall_intent= overall_intent,
        #           config_entities= config_entites,
        #           fallback_message_variants= fallback_message_variants,
        #           additional_conditions= additional_conditions,
        #           additional_updates= additional_updates
        #           )
        
        
        
        # print("outcomes are",outcome_name)
    # action["type"] = "dialogue"
    
    # actions = {f"slot-fill__{action_name}": action}
   
