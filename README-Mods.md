# Modifications

I created a `slot_fill_more` action type. Although there is a `web_plan` action type, this is evaluated as custom action and the rest of the functionality is inside `hovor`. 

The `slot_fill_more` action type concatenates different `slot_fill` type of actions together so that in the beginning, we can allow for multiple initial paths.

The following slight modifications have also been made: 

1. Addition of preconditions and effects inside the base `slot_fill` action that allows  concatenation of different variables as condition and effect. 