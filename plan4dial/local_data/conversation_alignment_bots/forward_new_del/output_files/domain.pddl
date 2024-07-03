(define
    (domain extended_ijcai)
    (:requirements :strips)
    (:types )
    (:constants )
    (:predicates
        (know__mental_state_description)
        (know__physical_state_description)
        (know__fire_context)
        (fire_context)
        (know__fire_color)
        (know__instrument)
        (know__smoke_description)
        (know__fire_smell)
        (know__location)
        (know__seen_smoke)
        (seen_smoke)
        (know_all_context_for_fire)
        (know_all_context_for_landing_gear_malfunction)
        (know_all_context_for_health)
        (know__server_error)
        (server_error)
        (no_instructions)
        (know__goal)
        (goal)
        (know__emergency_type)
        (know__reached_server)
        (know__landing_gear_specifier)
        (know__server_status)
        (server_status)
        (got_fire_instruction)
        (got_landing_gear_instruction)
        (got_health_instruction)
        (physical_health_emergency)
        (mental_health_emergency)
        (foam_request)
        (grass_request)
        (reset_condition)
        (force-statement)
        (allow_single_slot_location)
        (allow_single_slot_fire_color)
        (emergency_type-value-smoke_unknown_location_and_fire_known)
        (emergency_type-value-smell_known_location_required)
        (emergency_type-value-smoke_known_location_required)
        (emergency_type-value-landing_gear_malfunction_emergency)
        (emergency_type-value-physical_health_emergency)
        (emergency_type-value-mental_health_emergency)
    )
    (:action determine_emergency_s_u
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__fire_color)
                (know__location)
            )
        :effect
            (labeled-oneof determine_emergency_s_u__update
                (outcome update
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (emergency_type-value-smoke_unknown_location_and_fire_known)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (know__emergency_type)
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
            )
    )
    (:action determine_emergency_l_r
        :parameters()
        :precondition
            (and
                (know__fire_smell)
                (not (force-statement))
            )
        :effect
            (labeled-oneof determine_emergency_l_r__update
                (outcome update
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (know__emergency_type)
                        (emergency_type-value-smell_known_location_required)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
            )
    )
    (:action determine_emergency_s_k
        :parameters()
        :precondition
            (and
                (know__smoke_description)
                (not (force-statement))
            )
        :effect
            (labeled-oneof determine_emergency_s_k__update
                (outcome update
                    (and
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (know__emergency_type)
                        (emergency_type-value-smoke_known_location_required)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
            )
    )
    (:action determine_emergency_l_g
        :parameters()
        :precondition
            (and
                (know__landing_gear_specifier)
                (not (force-statement))
            )
        :effect
            (labeled-oneof determine_emergency_l_g__update
                (outcome update
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (know__emergency_type)
                        (emergency_type-value-landing_gear_malfunction_emergency)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
            )
    )
    (:action determine_emergency_p_h
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__physical_state_description)
            )
        :effect
            (labeled-oneof determine_emergency_p_h__update
                (outcome update
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (know__emergency_type)
                        (emergency_type-value-physical_health_emergency)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                    )
                )
            )
    )
    (:action determine_emergency_m_h
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__mental_state_description)
            )
        :effect
            (labeled-oneof determine_emergency_m_h__update
                (outcome update
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (know__emergency_type)
                        (emergency_type-value-mental_health_emergency)
                        (not (emergency_type-value-smell_known_location_required))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
            )
    )
    (:action inital_health_context
        :parameters()
        :precondition
            (and
                (not (physical_health_emergency))
                (not (mental_health_emergency))
                (know__emergency_type)
                (not (force-statement))
            )
        :effect
            (labeled-oneof inital_health_context__health_type
                (outcome physical
                    (and
                        (physical_health_emergency)
                    )
                )
                (outcome mental
                    (and
                        (mental_health_emergency)
                    )
                )
            )
    )
    (:action get-info_mental
        :parameters()
        :precondition
            (and
                (emergency_type-value-mental_health_emergency)
                (not (force-statement))
                (know__emergency_type)
                (not (know_all_context_for_health))
            )
        :effect
            (labeled-oneof get-info_mental__set-smoke
                (outcome indicate_no_addition
                    (and
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (emergency_type-value-physical_health_emergency)
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-info_physical
        :parameters()
        :precondition
            (and
                (emergency_type-value-physical_health_emergency)
                (not (force-statement))
                (know__emergency_type)
                (not (know_all_context_for_health))
            )
        :effect
            (labeled-oneof get-info_physical__set-smoke
                (outcome indicate_no_addition
                    (and
                        (know_all_context_for_health)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-smoke_from_fire
        :parameters()
        :precondition
            (and
                (emergency_type-value-smoke_unknown_location_and_fire_known)
                (not (know_all_context_for_fire))
                (not (know__seen_smoke))
                (not (force-statement))
                (know__emergency_type)
            )
        :effect
            (labeled-oneof get-smoke_from_fire__set-smoke
                (outcome indicate_smoke_not_seen
                    (and
                        (know_all_context_for_fire)
                        (know__seen_smoke)
                        (not (seen_smoke))
                    )
                )
                (outcome indicate_smoke_seen
                    (and
                        (seen_smoke)
                        (know__seen_smoke)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action smoke_from_dialog_location_color_known
        :parameters()
        :precondition
            (and
                (know__smoke_description)
                (emergency_type-value-smoke_unknown_location_and_fire_known)
                (not (force-statement))
                (know__emergency_type)
            )
        :effect
            (labeled-oneof smoke_from_dialog_location_color_known__set-context_known
                (outcome set-all_context_known
                    (and
                        (know_all_context_for_fire)
                    )
                )
            )
    )
    (:action smell_with_location_guess
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (emergency_type-value-smell_known_location_required)
                (know__location)
                (know__emergency_type)
            )
        :effect
            (labeled-oneof smell_with_location_guess__set-context_known
                (outcome set-all_context_known
                    (and
                        (know_all_context_for_fire)
                    )
                )
            )
    )
    (:action smoke_with_location_guess
        :parameters()
        :precondition
            (and
                (emergency_type-value-smoke_known_location_required)
                (not (force-statement))
                (know__location)
                (know__emergency_type)
            )
        :effect
            (labeled-oneof smoke_with_location_guess__set-context_known
                (outcome set-all_context_known
                    (and
                        (know_all_context_for_fire)
                    )
                )
            )
    )
    (:action landing_gear_malfunction_get_landing_type
        :parameters()
        :precondition
            (and
                (not (reset_condition))
                (not (force-statement))
                (not (grass_request))
                (know__landing_gear_specifier)
                (not (foam_request))
            )
        :effect
            (labeled-oneof landing_gear_malfunction_get_landing_type__set-context_known
                (outcome set-all_context_known_foam
                    (and
                        (know_all_context_for_landing_gear_malfunction)
                        (foam_request)
                    )
                )
                (outcome set-all_context_known_grass
                    (and
                        (know_all_context_for_landing_gear_malfunction)
                        (grass_request)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-fire_instruction
        :parameters()
        :precondition
            (and
                (not (got_fire_instruction))
                (know_all_context_for_fire)
                (not (know__reached_server))
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-fire_instruction__set-get-fire_instruction
                (outcome got_engine_fire_instruction
                    (and
                        (got_fire_instruction)
                        (know__reached_server)
                    )
                )
                (outcome got_engine_fire_instruction_false
                    (and
                        (know__reached_server)
                    )
                )
            )
    )
    (:action get-landing_gear_instruction
        :parameters()
        :precondition
            (and
                (know_all_context_for_landing_gear_malfunction)
                (not (got_fire_instruction))
                (not (know__reached_server))
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-landing_gear_instruction__set-get-fire_instruction
                (outcome got_engine_fire_instruction
                    (and
                        (got_landing_gear_instruction)
                        (know__reached_server)
                    )
                )
                (outcome got_engine_fire_instruction_false
                    (and
                        (not (got_landing_gear_instruction))
                        (know__reached_server)
                    )
                )
            )
    )
    (:action get-health_instruction
        :parameters()
        :precondition
            (and
                (know_all_context_for_health)
                (not (force-statement))
                (not (know__reached_server))
                (not (got_health_instruction))
            )
        :effect
            (labeled-oneof get-health_instruction__set-get-fire_instruction
                (outcome got_engine_fire_instruction
                    (and
                        (know__reached_server)
                        (got_health_instruction)
                    )
                )
                (outcome got_engine_fire_instruction_false
                    (and
                        (know__reached_server)
                    )
                )
            )
    )
    (:action complete-fire
        :parameters()
        :precondition
            (and
                (got_fire_instruction)
                (not (force-statement))
            )
        :effect
            (labeled-oneof complete-fire__finish
                (outcome finish
                    (and
                        (goal)
                    )
                )
            )
    )
    (:action complete
        :parameters()
        :precondition
            (and
                (got_landing_gear_instruction)
                (not (force-statement))
            )
        :effect
            (labeled-oneof complete__finish
                (outcome finish
                    (and
                        (goal)
                    )
                )
            )
    )
    (:action complete_health
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (got_health_instruction)
            )
        :effect
            (labeled-oneof complete_health__finish
                (outcome finish
                    (and
                        (goal)
                    )
                )
            )
    )
    (:action complete_error
        :parameters()
        :precondition
            (and
                (not (got_landing_gear_instruction))
                (not (got_health_instruction))
                (know__reached_server)
                (not (got_fire_instruction))
                (not (force-statement))
            )
        :effect
            (labeled-oneof complete_error__finish
                (outcome finish
                    (and
                        (goal)
                    )
                )
            )
    )
    (:action dialogue_statement
        :parameters()
        :precondition
            (and
                (force-statement)
            )
        :effect
            (labeled-oneof dialogue_statement__reset
                (outcome lock
                    (and
                        (not (force-statement))
                    )
                )
            )
    )
    (:action single_slot__location
        :parameters()
        :precondition
            (and
                (allow_single_slot_location)
                (not (know__location))
                (not (force-statement))
            )
        :effect
            (labeled-oneof single_slot__location__validate-slot-fill
                (outcome fill-slot
                    (and
                        (force-statement)
                        (know__location)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action single_slot__fire_color
        :parameters()
        :precondition
            (and
                (not (know__fire_color))
                (allow_single_slot_fire_color)
                (not (force-statement))
            )
        :effect
            (labeled-oneof single_slot__fire_color__validate-slot-fill
                (outcome fill-slot
                    (and
                        (force-statement)
                        (know__fire_color)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action fire_emergency_location_color_driven
        :parameters()
        :precondition
            (and
                (not (know__physical_state_description))
                (not (know__fire_smell))
                (not (know__landing_gear_specifier))
                (not (know__mental_state_description))
                (not (force-statement))
                (not (know__smoke_description))
                (not (know__fire_color))
                (not (know__location))
            )
        :effect
            (labeled-oneof fire_emergency_location_color_driven__validate-slot-fill-more
                (outcome fire_color_found-location_found
                    (and
                        (know__fire_color)
                        (know__location)
                    )
                )
                (outcome fire_color_found
                    (and
                        (force-statement)
                        (know__fire_color)
                        (allow_single_slot_location)
                    )
                )
                (outcome location_found
                    (and
                        (force-statement)
                        (allow_single_slot_fire_color)
                        (know__location)
                    )
                )
                (outcome fire_smell_found
                    (and
                        (force-statement)
                        (not (emergency_type-value-smoke_known_location_required))
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (know__fire_smell)
                        (emergency_type-value-smell_known_location_required)
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-mental_health_emergency))
                        (know__emergency_type)
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
                (outcome smoke_description_found
                    (and
                        (force-statement)
                        (not (emergency_type-value-landing_gear_malfunction_emergency))
                        (emergency_type-value-smoke_known_location_required)
                        (know__smoke_description)
                        (not (emergency_type-value-smoke_unknown_location_and_fire_known))
                        (not (emergency_type-value-mental_health_emergency))
                        (not (emergency_type-value-smell_known_location_required))
                        (know__emergency_type)
                        (not (emergency_type-value-physical_health_emergency))
                    )
                )
                (outcome landing_gear_specifier_found
                    (and
                        (know__landing_gear_specifier)
                    )
                )
                (outcome physical_state_description_found
                    (and
                        (force-statement)
                        (know__physical_state_description)
                    )
                )
                (outcome mental_state_description_found
                    (and
                        (force-statement)
                        (know__mental_state_description)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action slot-fill__get-location_for_smell_driven
        :parameters()
        :precondition
            (and
                (emergency_type-value-smell_known_location_required)
                (not (know__location))
                (not (force-statement))
            )
        :effect
            (labeled-oneof slot-fill__get-location_for_smell_driven__validate-slot-fill
                (outcome location_found
                    (and
                        (force-statement)
                        (know__location)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action slot-fill__get-location_for_smoke_driven
        :parameters()
        :precondition
            (and
                (emergency_type-value-smoke_known_location_required)
                (not (know__location))
                (not (force-statement))
            )
        :effect
            (labeled-oneof slot-fill__get-location_for_smoke_driven__validate-slot-fill
                (outcome location_found
                    (and
                        (force-statement)
                        (know__location)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action slot-fill__get-smoke_description
        :parameters()
        :precondition
            (and
                (seen_smoke)
                (not (know__smoke_description))
                (not (force-statement))
                (know__seen_smoke)
            )
        :effect
            (labeled-oneof slot-fill__get-smoke_description__validate-slot-fill
                (outcome smoke_description_found
                    (and
                        (know__smoke_description)
                        (force-statement)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
)