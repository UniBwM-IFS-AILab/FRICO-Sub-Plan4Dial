(define
    (domain day-planner)
    (:requirements :strips :typing)
    (:types )
    (:constants )
    (:predicates
        (know__cuisine)
        (know__restaurant)
        (know__have_allergy)
        (have_allergy)
        (know__food_restriction)
        (know__conflict)
        (conflict)
        (know__low_budget)
        (low_budget)
        (know__outing_atmosphere)
        (know__goal)
        (goal)
        (have-message)
        (force-statement)
        (food_restriction-value-dairy-free)
        (food_restriction-value-gluten-free)
        (cuisine-value-mexican)
        (cuisine-value-italian)
        (cuisine-value-chinese)
        (cuisine-value-dessert)
    )
    (:action get-have-allergy
        :parameters()
        (:precondition
            (and
                (not (force-statement))
                (not (know__have_allergy))
            )
        )
        :effect
            (labeled-oneof set-allergy
                (outcome indicate_allergy
                    (and
                        (have_allergy)
                        (know__have_allergy)
                    )
                )
                (outcome indicate_no_allergy
                    (and
                        (not (have_allergy))
                        (know__have_allergy)
                        (not (conflict))
                        (know__conflict)
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
    (:action get-allergy
        :parameters()
        (:precondition
            (and
                (have_allergy)
                (know__have_allergy)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof set-allergy
                (outcome update_allergy
                    (and
                        (know__food_restriction)
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
    (:action reset-preferences
        :parameters()
        (:precondition
            (and
                (know__conflict)
                (not (force-statement))
                (conflict)
            )
        )
        :effect
            (labeled-oneof reset
                (outcome reset-values
                    (and
                        (not (know__cuisine))
                        (not (cuisine-value-dessert))
                        (have-message)
                        (not (food_restriction-value-gluten-free))
                        (not (cuisine-value-chinese))
                        (not (know__conflict))
                        (force-statement)
                        (not (cuisine-value-italian))
                        (not (cuisine-value-mexican))
                        (not (food_restriction-value-dairy-free))
                        (not (know__food_restriction))
                        (not (know__have_allergy))
                    )
                )
            )
    )
    (:action set-restaurant
        :parameters()
        (:precondition
            (and
                (know__cuisine)
                (not (conflict))
                (know__conflict)
                (not (know__restaurant))
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof assign_restaurant
                (outcome set-mexican
                    (and
                        (know__restaurant)
                    )
                )
                (outcome set-italian
                    (and
                        (know__restaurant)
                    )
                )
                (outcome set-chinese
                    (and
                        (know__restaurant)
                    )
                )
                (outcome set-dessert
                    (and
                        (know__restaurant)
                    )
                )
            )
    )
    (:action complete
        :parameters()
        (:precondition
            (and
                (know__restaurant)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof finish
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
        (:precondition
            (and
                (force-statement)
                (have-message)
            )
        )
        :effect
            (labeled-oneof reset
                (outcome lock
                    (and
                        (not (have-message))
                        (not (force-statement))
                    )
                )
            )
    )
    (:action slot-fill__get-cuisine
        :parameters()
        (:precondition
            (and
                (not (know__cuisine))
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof validate-slot-fill
                (outcome cuisine_found
                    (and
                        (know__cuisine)
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
    (:action clarify__cuisine
        :parameters()
        (:precondition
            (and
                (not (know__cuisine))
                (maybe-know__cuisine)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof validate-clarification
                (outcome confirm
                    (and
                        (know__cuisine)
                    )
                )
                (outcome deny
                    (and
                        (not (know__cuisine))
                        (not (cuisine-value-dessert))
                        (not (cuisine-value-chinese))
                        (not (cuisine-value-italian))
                        (not (cuisine-value-mexican))
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
    (:action check-conflict-1-or-1
        :parameters()
        (:precondition
            (and
                (cuisine-value-mexican)
                (have_allergy)
                (know__have_allergy)
                (food_restriction-value-gluten-free)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (know__conflict)
                        (conflict)
                    )
                )
            )
    )
    (:action check-conflict-1-or-2
        :parameters()
        (:precondition
            (and
                (food_restriction-value-dairy-free)
                (have_allergy)
                (know__have_allergy)
                (cuisine-value-dessert)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (know__conflict)
                        (conflict)
                    )
                )
            )
    )
    (:action check-conflict-2-or-1
        :parameters()
        (:precondition
            (and
                (have_allergy)
                (know__have_allergy)
                (cuisine-value-italian)
                (know__food_restriction)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (not (conflict))
                        (know__conflict)
                    )
                )
            )
    )
    (:action check-conflict-2-or-2
        :parameters()
        (:precondition
            (and
                (cuisine-value-chinese)
                (have_allergy)
                (know__have_allergy)
                (know__food_restriction)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (not (conflict))
                        (know__conflict)
                    )
                )
            )
    )
    (:action check-conflict-2-or-3
        :parameters()
        (:precondition
            (and
                (cuisine-value-mexican)
                (food_restriction-value-dairy-free)
                (have_allergy)
                (know__have_allergy)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (not (conflict))
                        (know__conflict)
                    )
                )
            )
    )
    (:action check-conflict-2-or-4
        :parameters()
        (:precondition
            (and
                (have_allergy)
                (know__have_allergy)
                (food_restriction-value-gluten-free)
                (cuisine-value-dessert)
                (not (force-statement))
            )
        )
        :effect
            (labeled-oneof check-conflicts
                (outcome validate-combos
                    (and
                        (not (conflict))
                        (know__conflict)
                    )
                )
            )
    )
    (:action set-food_restriction
        :parameters()
        (:precondition
            (and
                (not (food_restriction-value-gluten-free))
                (not (food_restriction-value-dairy-free))
                (know__food_restriction)
            )
        )
        :effect
            (labeled-oneof set-valid-value
                (outcome dairy-free
                    (and
                        (food_restriction-value-dairy-free)
                    )
                )
                (outcome gluten-free
                    (and
                        (food_restriction-value-gluten-free)
                    )
                )
            )
    )
    (:action set-cuisine
        :parameters()
        (:precondition
            (and
                (not (cuisine-value-dessert))
                (not (cuisine-value-chinese))
                (not (cuisine-value-italian))
                (not (cuisine-value-mexican))
                (know__cuisine)
            )
        )
        :effect
            (labeled-oneof set-valid-value
                (outcome mexican
                    (and
                        (cuisine-value-mexican)
                    )
                )
                (outcome italian
                    (and
                        (cuisine-value-italian)
                    )
                )
                (outcome chinese
                    (and
                        (cuisine-value-chinese)
                    )
                )
                (outcome dessert
                    (and
                        (cuisine-value-dessert)
                    )
                )
            )
    )
)