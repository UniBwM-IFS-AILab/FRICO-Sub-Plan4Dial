(define
    (domain extended_ijcai)
    (:requirements :strips)
    (:types )
    (:constants )
    (:predicates
        (know__request_emergency_help)
        (maybe-know__request_emergency_help)
        (request_emergency_help)
        (request_electric_fire_help)
        (request_engine_fire_help)
        (know__request_wing_fire_help)
        (request_wing_fire_help)
        (got_instruction)
        (got_status)
        (got_instruction_engine_fire)
        (got_instruction_electric_fire)
        (informed)
        (need_further_help)
        (not_feeling_well)
        (got-from_server)
        (sub_dialog_reset)
        (second_flag)
        (know__fire_color)
        (know__instrument)
        (know__fire_type)
        (know__instructions_type)
        (know__dummy_code)
        (ctx_two)
        (know__server_error)
        (server_error)
        (know__goal)
        (goal)
        (force-statement)
        (forcing__get-restart_conversation)
    )
    (:action get-initial_help_request
        :parameters()
        :precondition
            (and
                (not (know__request_emergency_help))
                (not (forcing__get-restart_conversation))
                (not (force-statement))
                (not (request_emergency_help))
                (not (maybe-know__request_emergency_help))
            )
        :effect
            (labeled-oneof get-initial_help_request__set-emergency_help_type
                (outcome update-generic_fire_emergency
                    (and
                        (know__request_emergency_help)
                        (request_emergency_help)
                    )
                )
                (outcome update-reset
                    (and
                        (forcing__get-restart_conversation)
                        (sub_dialog_reset)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-restart_conversation
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (sub_dialog_reset)
            )
        :effect
            (labeled-oneof get-restart_conversation__set-second_flag
                (outcome update-second_flag
                    (and
                        (second_flag)
                        (not (forcing__get-restart_conversation))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (not (forcing__get-restart_conversation))
                    )
                )
            )
    )
    (:action get-fire_type
        :parameters()
        :precondition
            (and
                (not (forcing__get-restart_conversation))
                (not (force-statement))
                (know__request_emergency_help)
                (not (maybe-know__request_emergency_help))
                (request_emergency_help)
            )
        :effect
            (labeled-oneof get-fire_type__set-engine_fire_emergency
                (outcome update-engine_fire_emergency
                    (and
                        (know__fire_type)
                    )
                )
                (outcome update-electric_fire_emergency
                    (and
                        (know__fire_type)
                    )
                )
                (outcome update-reset
                    (and
                        (sub_dialog_reset)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action intermediate-context
        :parameters()
        :precondition
            (and
                (not (ctx_two))
                (not (forcing__get-restart_conversation))
                (not (request_engine_fire_help))
                (not (request_electric_fire_help))
                (not (force-statement))
                (know__fire_type)
            )
        :effect
            (labeled-oneof intermediate-context__set-complete
                (outcome update-context_two
                    (and
                        (ctx_two)
                        (request_engine_fire_help)
                    )
                )
                (outcome update-context_one
                    (and
                        (ctx_two)
                        (request_electric_fire_help)
                    )
                )
            )
    )
    (:action get-engine_fire_instruction
        :parameters()
        :precondition
            (and
                (know__fire_color)
                (not (force-statement))
                (not (forcing__get-restart_conversation))
            )
        :effect
            (labeled-oneof get-engine_fire_instruction__set-get-engine_fire_instruction
                (outcome update-got_engine_fire_instruction
                    (and
                        (got_instruction_engine_fire)
                        (got-from_server)
                    )
                )
                (outcome update-got_engine_fire_instruction_false
                    (and
                        (server_error)
                        (know__server_error)
                    )
                )
            )
    )
    (:action get-electric_fire_instruction
        :parameters()
        :precondition
            (and
                (not (forcing__get-restart_conversation))
                (not (got_instruction_electric_fire))
                (not (force-statement))
                (know__instrument)
            )
        :effect
            (labeled-oneof get-electric_fire_instruction__set-get-electric_fire_instruction
                (outcome update-got_electric_fire_instruction
                    (and
                        (know__instructions_type)
                        (got-from_server)
                    )
                )
                (outcome update-got_electric_fire_instruction_false
                    (and
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action final-context
        :parameters()
        :precondition
            (and
                (got-from_server)
                (not (forcing__get-restart_conversation))
                (know__instructions_type)
                (not (force-statement))
                (not (know__dummy_code))
            )
        :effect
            (labeled-oneof final-context__set-complete
                (outcome update-electric_fire
                    (and
                        (know__dummy_code)
                    )
                )
                (outcome update-engine_fire
                    (and
                        (got_status)
                        (know__dummy_code)
                    )
                )
                (outcome update-error
                    (and
                        (know__dummy_code)
                    )
                )
            )
    )
    (:action get-need_further_help
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__dummy_code)
                (not (forcing__get-restart_conversation))
            )
        :effect
            (labeled-oneof get-need_further_help__finish
                (outcome finish
                    (and
                        (force-statement)
                        (need_further_help)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action complete
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (need_further_help)
                (not (forcing__get-restart_conversation))
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
    (:action slot-fill__get-fire_color
        :parameters()
        :precondition
            (and
                (not (know__fire_color))
                (not (force-statement))
                (request_engine_fire_help)
                (not (forcing__get-restart_conversation))
            )
        :effect
            (labeled-oneof slot-fill__get-fire_color__validate-slot-fill
                (outcome fire_color_found
                    (and
                        (know__fire_color)
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