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
        (finish)
        (know__goal)
        (goal)
        (force-statement)
    )
    (:action get-fire_information-one
        :parameters()
        :precondition
            (and
                (not (maybe-know__fire_type))
                (not (know__fire_type))
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-fire_information-one__set-emergency_type
                (outcome update-proceed_flag
                    (and
                        (proceed_flag)
                    )
                )
                (outcome update-engine_fire
                    (and
                        (proceed_flag)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action get-fire_information
        :parameters()
        :precondition
            (and
                (proceed_flag)
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-fire_information__set-emergency_type
                (outcome update-engine_fire
                    (and
                        (informed)
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
                (informed)
                (not (force-statement))
            )
        :effect
            (labeled-oneof set-informed__set-informed
                (outcome update-informed
                    (and
                        (finish)
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