(define
    (domain order-pizza)
    (:requirements         :strips :typing)
    (:types )
    (:constants )
    (:predicates
        (informed_user)
        (available-7)
        (available-8)
        (available-9)
        (attending-7)
        (attending-8)
        (know__attending-9)
        (goal)
        (have-message)
        (force-statement)
    )
    (:action start
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (not (informed_user))
            )
        :effect
            (labeled-oneof         start
                (outcome inform
                    (and
                        (informed_user)
                    )
                )
            )
    )
    (:action get-attending-9
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (not (know__attending-9))
                (available-9)
            )
        :effect
            (labeled-oneof         get-response
                (outcome choose-preference
                    (and
                        (know__attending-9)
                    )
                )
                (outcome do-not-attend
                    (and
                        (know__attending-9)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
    (:action complete
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__attending-9)
                (know__attending-8)
                (know__attending-7)
            )
        :effect
            (labeled-oneof         finish
                (outcome finish
                    (and
                        (know__goal)
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
                (have-message)
            )
        :effect
            (labeled-oneof         reset
                (outcome lock
                    (and
                        (not (force-statement))
                        (not (have-message))
                    )
                )
            )
    )
    (:action slot-fill__get-available-7
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (not (know__available-7))
            )
        :effect
            (labeled-oneof         get-response
                (outcome confirm_outcome
                    (and
                        (know__available-7)
                        (available-7)
                    )
                )
                (outcome deny_outcome
                    (and
                        (know__available-7)
                        (not (available-7))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
    (:action slot-fill__get-available-8
        :parameters()
        :precondition
            (and
                (not (know__available-8))
                (know__available-7)
                (not (force-statement))
            )
        :effect
            (labeled-oneof         get-response
                (outcome confirm_outcome
                    (and
                        (available-8)
                        (know__available-8)
                    )
                )
                (outcome deny_outcome
                    (and
                        (not (available-8))
                        (know__available-8)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
    (:action slot-fill__get-available-9
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (know__available-9)
            )
        :effect
            (labeled-oneof         get-response
                (outcome confirm_outcome
                    (and
                        (know__available-9)
                        (available-9)
                    )
                )
                (outcome deny_outcome
                    (and
                        (know__available-9)
                        (not (available-9))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
    (:action slot-fill__get-attending-7
        :parameters()
        :precondition
            (and
                (not (know__attending-7))
                (not (force-statement))
                (available-7)
            )
        :effect
            (labeled-oneof         get-response
                (outcome confirm_outcome
                    (and
                        (attending-7)
                        (know__attending-7)
                    )
                )
                (outcome deny_outcome
                    (and
                        (not (attending-7))
                        (know__attending-7)
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
    (:action slot-fill__get-attending-8
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (available-8)
                (not (know__attending-8))
            )
        :effect
            (labeled-oneof         get-response
                (outcome confirm_outcome
                    (and
                        (know__attending-8)
                        (attending-8)
                    )
                )
                (outcome deny_outcome
                    (and
                        (know__attending-8)
                        (not (attending-8))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                        (have-message)
                    )
                )
            )
    )
)
