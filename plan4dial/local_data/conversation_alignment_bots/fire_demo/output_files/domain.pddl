(define
    (domain frico_fire)
    (:requirements :strips)
    (:types )
    (:constants )
    (:predicates
        (know__request_emergency_help)
        (maybe-know__request_emergency_help)
        (request_emergency_help)
        (know__request_electric_fire_help)
        (request_electric_fire_help)
        (know__request_engine_fire_help)
        (request_engine_fire_help)
        (know__request_wing_fire_help)
        (request_wing_fire_help)
        (informed)
        (know__goal)
        (goal)
        (force-statement)
    )
    (:action get-initial_help_request
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (not (request_emergency_help))
                (not (maybe-know__request_emergency_help))
                (not (know__request_emergency_help))
            )
        :effect
            (labeled-oneof get-initial_help_request__set-emergency_help_type
                (outcome update-generic_fire_emergency
                    (and
                        (know__request_emergency_help)
                        (request_emergency_help)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-fire_type
        :parameters()
        :precondition
            (and
                (know__request_emergency_help)
                (not (maybe-know__request_emergency_help))
                (request_emergency_help)
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-fire_type__set-engine_fire_emergency
                (outcome update-engine_fire_emergency
                    (and
                        (force-statement)
                        (request_engine_fire_help)
                        (know__request_engine_fire_help)
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
                (request_engine_fire_help)
                (know__request_engine_fire_help)
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
)