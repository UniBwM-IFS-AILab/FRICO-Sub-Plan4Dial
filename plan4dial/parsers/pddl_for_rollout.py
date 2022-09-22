"""This module contains all the functions necessary to store the PDDL fluent
configuration in an easy-to-access way so that given an action, we can easily
retrieve what fluents are in its preconditions and which fluents are in each
of its outcomes. This is only used for the rollout implementation for beam
search, as it needs to be able to traverse the conversation based on ALL
applicable actions and not just the solution generated by the PRP planner.

Authors:
- Rebecca De Venezia
"""

from plan4dial.parsers.pddl_parser import (
    _get_precond_fluents,
    _get_update_fluents,
    _parse_init,
)
from typing import List


def convert_to_hovor_fluents(fluents: List[str]):
    not_str = "(not "
    for i in range(len(fluents)):
        if not_str in fluents[i]:
            fluents[i] = f"NegatedAtom {fluents[i].split(not_str)[1][1:-2]}()"
        else:
            fluents[i] = f"Atom {fluents[i][1:-1]}()"
    return fluents


def rollout_config(configuration):
    actions = {
        act: {
            "condition": convert_to_hovor_fluents(
                list(
                    _get_precond_fluents(
                        configuration["context_variables"], act_cfg["condition"]
                    )
                )
            ),
            "effect": {},
        }
        for act, act_cfg in configuration["actions"].items()
    }
    for act, act_cfg in configuration["actions"].items():
        for out in act_cfg["effect"]["outcomes"]:
            if "updates" in out:
                actions[act]["effect"][out["name"]] = convert_to_hovor_fluents(
                    list(
                        _get_update_fluents(
                            configuration["context_variables"], out["updates"]
                        )
                    )
                )
    return {
        "actions": actions,
        "initial_state": convert_to_hovor_fluents(
            list(_parse_init(configuration["context_variables"])[1])
        ),
    }
