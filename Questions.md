

1, How to create resetable actions?


My approach for resetable action: 
    1. If my NLU_outcome_determiner determines the intent does not belong to  the intents are expected as outcomes by my model. I update a flag variable to be true, and when this flag variable is true,  I reset all the variables to false for example

1. You cannot update the variables other than config entites using slot fill. Is there a reason for that?  In the docs, it says it should be doable, so is only the implementation missing?
2. Is the preconditions using or and when supported right now in the  main branch? https://github.com/dialogue-planning/plan4dial/issues/4 I get PDDL is invalid 
3. Webcalls review. 
4. Is there a reason why in context dependent determination, only value for the config variables's value can be checked in while i am running through a server. Maybe just a bug?

5. Any information on the size of the graph?



