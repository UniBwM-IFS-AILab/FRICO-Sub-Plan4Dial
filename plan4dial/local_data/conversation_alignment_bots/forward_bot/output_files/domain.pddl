(define
    (domain forward_bot)
    (:requirements :strips)
    (:types )
    (:constants )
    (:predicates
        (started)
        (informed)
        (proceed_flag)
        (request_emergency_help)
        (know__fire_type)
        (maybe-know__fire_type)
        (reset)
        (know__goal)
        (goal)
        (force-statement)
    )
    (:action get-fire_information
        :parameters()
        :precondition
            (and
                (not (request_emergency_help))
                (not (proceed_flag))
                (not (know__fire_type))
                (not (force-statement))
                (not (maybe-know__fire_type))
            )
        :effect
            (labeled-oneof get-fire_information__set-emergency_type
                (outcome update-proceed_flag
                    (and
                        (proceed_flag)
                    )
                )
                (outcome update-engine_fire
                    (and
                        (request_emergency_help)
                        (maybe-know__fire_type)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action confirm-fire_information
        :parameters()
        :precondition
            (and
                (request_emergency_help)
                (maybe-know__fire_type)
                (not (force-statement))
                (not (know__fire_type))
            )
        :effect
            (labeled-oneof confirm-fire_information__set-emergency_type
                (outcome update-proceed_flag
                    (and
                        (reset)
                    )
                )
                (outcome update-engine_fire
                    (and
                        (know__fire_type)
                        (proceed_flag)
                        (not (maybe-know__fire_type))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action reset-convo
        :parameters()
        :precondition
            (and
                (reset)
                (not (force-statement))
            )
        :effect
            (labeled-oneof reset-convo__reset-convo
                (outcome update-proceed_flag
                    (and
                        (not (request_emergency_help))
                        (not (proceed_flag))
                    )
                )
            )
    )
    (:action set-informed
        :parameters()
        :precondition
            (and
                (proceed_flag)
                (not (force-statement))
            )
        :effect
            (labeled-oneof set-informed__set-informed
                (outcome update-informed
                    (and
                        (informed)
                    )
                )
            )
    )
    (:action complete
        :parameters()
        :precondition
            (and
                (informed)
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
)