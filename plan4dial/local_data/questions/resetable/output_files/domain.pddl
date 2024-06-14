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
        (got_from_server)
        (know__server_status)
        (server_status)
        (sub_dialog_reset)
        (second_flag)
        (know__fire_color)
        (know__instrument)
        (know__fire_type)
        (know__instructions_type)
        (know__dummy_code)
        (ctx_two)
        (know__ctx_three)
        (ctx_three)
        (know__server_error)
        (server_error)
        (know__goal)
        (goal)
        (force-statement)
        (forcing__restart)
        (fire_type-value-engine)
        (fire_type-value-electric)
        (fire_type-value-none)
    )
    (:action get-initial_help_request
        :parameters()
        :precondition
            (and
                (not (maybe-know__request_emergency_help))
                (not (request_emergency_help))
                (not (know__request_emergency_help))
                (not (force-statement))
                (not (forcing__restart))
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
                        (forcing__restart)
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
    (:action restart
        :parameters()
        :precondition
            (and
                (sub_dialog_reset)
                (not (force-statement))
            )
        :effect
            (labeled-oneof restart__set-second_flag
                (outcome update-second_flag
                    (and
                        (not (forcing__restart))
                        (second_flag)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (not (forcing__restart))
                    )
                )
            )
    )
    (:action get-fire_type
        :parameters()
        :precondition
            (and
                (not (maybe-know__request_emergency_help))
                (know__request_emergency_help)
                (not (force-statement))
                (not (forcing__restart))
                (request_emergency_help)
            )
        :effect
            (labeled-oneof get-fire_type__set-engine_fire_emergency
                (outcome update-engine_fire_emergency
                    (and
                        (fire_type-value-engine)
                        (not (fire_type-value-none))
                        (know__fire_type)
                        (not (fire_type-value-electric))
                    )
                )
                (outcome update-electric_fire_emergency
                    (and
                        (fire_type-value-electric)
                        (not (fire_type-value-engine))
                        (not (fire_type-value-none))
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
                (not (request_engine_fire_help))
                (not (ctx_two))
                (not (request_electric_fire_help))
                (not (force-statement))
                (know__fire_type)
                (not (forcing__restart))
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
    (:action update-after_slot_fill_engine_fire
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (not (forcing__restart))
                (know__fire_color)
            )
        :effect
            (labeled-oneof update-after_slot_fill_engine_fire__update
                (outcome update
                    (and
                        (fire_type-value-engine)
                        (not (fire_type-value-none))
                        (not (fire_type-value-electric))
                        (know__ctx_three)
                        (know__fire_type)
                        (ctx_three)
                    )
                )
            )
    )
    (:action get-engine_fire_instruction
        :parameters()
        :precondition
            (and
                (fire_type-value-engine)
                (not (force-statement))
                (not (got_instruction_engine_fire))
                (know__ctx_three)
                (know__fire_type)
                (ctx_three)
                (not (forcing__restart))
            )
        :effect
            (labeled-oneof get-engine_fire_instruction__set-get-engine_fire_instruction
                (outcome update-got_engine_fire_instruction
                    (and
                        (got_instruction_engine_fire)
                        (server_status)
                        (know__server_status)
                    )
                )
                (outcome update-got_engine_fire_instruction_false
                    (and
                        (not (know__server_status))
                        (server_status)
                    )
                )
                (outcome update-reset
                    (and
                        (forcing__restart)
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
    (:action get-electric_fire_instruction
        :parameters()
        :precondition
            (and
                (fire_type-value-electric)
                (not (force-statement))
                (know__ctx_three)
                (know__fire_type)
                (ctx_three)
                (not (forcing__restart))
            )
        :effect
            (labeled-oneof get-electric_fire_instruction__set-get-engine_fire_instruction
                (outcome update-got_engine_fire_instruction
                    (and
                        (got_instruction_electric_fire)
                        (server_status)
                        (know__server_status)
                    )
                )
                (outcome update-got_engine_fire_instruction_false
                    (and
                        (not (know__server_status))
                        (server_status)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action update-after_slot_fill_electric_fire
        :parameters()
        :precondition
            (and
                (not (forcing__restart))
                (not (force-statement))
                (know__instrument)
            )
        :effect
            (labeled-oneof update-after_slot_fill_electric_fire__update
                (outcome update
                    (and
                        (fire_type-value-electric)
                        (not (fire_type-value-none))
                        (not (fire_type-value-engine))
                        (know__ctx_three)
                        (know__fire_type)
                        (ctx_three)
                    )
                )
            )
    )
    (:action final-context
        :parameters()
        :precondition
            (and
                (not (know__dummy_code))
                (not (force-statement))
                (know__ctx_three)
                (know__fire_type)
                (ctx_three)
                (not (forcing__restart))
                (know__server_status)
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
                (not (forcing__restart))
                (not (force-statement))
                (know__dummy_code)
            )
        :effect
            (labeled-oneof get-need_further_help__set-complete
                (outcome update-need_further_help
                    (and
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
                (need_further_help)
                (not (forcing__restart))
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
    (:action slot-filler__get-fire_color
        :parameters()
        :precondition
            (and
                (request_engine_fire_help)
                (not (force-statement))
                (not (know__fire_color))
                (not (forcing__restart))
            )
        :effect
            (labeled-oneof slot-filler__get-fire_color__validate-slot-fill
                (outcome fire_color_found
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
    (:action slot-filler__get-instrument_on_fire
        :parameters()
        :precondition
            (and
                (not (know__instrument))
                (not (forcing__restart))
                (not (force-statement))
                (request_electric_fire_help)
            )
        :effect
            (labeled-oneof slot-filler__get-instrument_on_fire__validate-slot-fill
                (outcome instrument_found
                    (and
                        (force-statement)
                        (know__instrument)
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