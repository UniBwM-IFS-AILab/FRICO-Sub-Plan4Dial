(define
    (domain or_test)
    (:requirements :strips)
    (:types )
    (:constants )
    (:predicates
        (know__cuisine)
        (know__restaurant)
        (test)
        (know__goal)
        (goal)
        (force-statement)
        (cuisine-value-mexican)
        (cuisine-value-italian)
        (cuisine-value-chinese)
        (cuisine-value-dessert)
        (cuisine-value-bar_food)
    )
    (:action get-cuisine
        :parameters()
        :precondition
            (and
                (not (know__cuisine))
                (not (force-statement))
            )
        :effect
            (labeled-oneof get-cuisine__set-cuisine
                (outcome valid
                    (and
                        (know__cuisine)
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (not (cuisine-value-mexican))
                        (not (cuisine-value-bar_food))
                    )
                )
                (outcome fallback
                    (and
                        (force-statement)
                    )
                )
            )
    )
    (:action test_and
        :parameters()
        :precondition
            (and
                (know__cuisine)
                (cuisine-value-dessert)
                (not (force-statement))
            )
        :effect
            (labeled-oneof test_and__done
                (outcome done
                    (and
                        (test)
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
    (:action test_or-or-1
        :parameters()
        :precondition
            (and
                (cuisine-value-italian)
                (not (force-statement))
            )
        :effect
            (labeled-oneof test_or-or-1__done
                (outcome done
                    (and
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (goal)
                        (not (cuisine-value-mexican))
                        (not (know__cuisine))
                        (not (cuisine-value-bar_food))
                    )
                )
            )
    )
    (:action test_or-or-2
        :parameters()
        :precondition
            (and
                (cuisine-value-mexican)
                (not (force-statement))
            )
        :effect
            (labeled-oneof test_or-or-2__done
                (outcome done
                    (and
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (goal)
                        (not (cuisine-value-mexican))
                        (not (know__cuisine))
                        (not (cuisine-value-bar_food))
                    )
                )
            )
    )
    (:action test_or-or-3
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (cuisine-value-chinese)
            )
        :effect
            (labeled-oneof test_or-or-3__done
                (outcome done
                    (and
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (goal)
                        (not (cuisine-value-mexican))
                        (not (know__cuisine))
                        (not (cuisine-value-bar_food))
                    )
                )
            )
    )
    (:action test_or-or-4
        :parameters()
        :precondition
            (and
                (test)
                (cuisine-value-dessert)
                (not (force-statement))
            )
        :effect
            (labeled-oneof test_or-or-4__done
                (outcome done
                    (and
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (goal)
                        (not (cuisine-value-mexican))
                        (not (know__cuisine))
                        (not (cuisine-value-bar_food))
                    )
                )
            )
    )
    (:action test_or-or-5
        :parameters()
        :precondition
            (and
                (not (force-statement))
                (cuisine-value-bar_food)
            )
        :effect
            (labeled-oneof test_or-or-5__done
                (outcome done
                    (and
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-chinese))
                        (goal)
                        (not (cuisine-value-mexican))
                        (not (know__cuisine))
                        (not (cuisine-value-bar_food))
                    )
                )
            )
    )
)