begin_version
3
end_version
begin_metric
0
end_metric
14
begin_variable
var0
-1
2
Atom know__emergency_type()
NegatedAtom know__emergency_type()
end_variable
begin_variable
var1
-1
2
Atom know__fire_context()
NegatedAtom know__fire_context()
end_variable
begin_variable
var2
-1
2
Atom require_smoke_info()
NegatedAtom require_smoke_info()
end_variable
begin_variable
var3
-1
2
Atom know__seen_smoke()
NegatedAtom know__seen_smoke()
end_variable
begin_variable
var4
-1
2
Atom know__smoke_description()
NegatedAtom know__smoke_description()
end_variable
begin_variable
var5
-1
2
Atom seen_smoke()
NegatedAtom seen_smoke()
end_variable
begin_variable
var6
-1
2
Atom know_all_context_for_fire()
NegatedAtom know_all_context_for_fire()
end_variable
begin_variable
var7
-1
2
Atom allow_single_slot_fire_color()
NegatedAtom allow_single_slot_fire_color()
end_variable
begin_variable
var8
-1
2
Atom allow_single_slot_location()
NegatedAtom allow_single_slot_location()
end_variable
begin_variable
var9
-1
2
Atom know__fire_color()
NegatedAtom know__fire_color()
end_variable
begin_variable
var10
-1
2
Atom know__location()
NegatedAtom know__location()
end_variable
begin_variable
var11
-1
2
Atom force-statement()
NegatedAtom force-statement()
end_variable
begin_variable
var12
-1
2
Atom need_further_help()
NegatedAtom need_further_help()
end_variable
begin_variable
var13
-1
2
Atom goal()
NegatedAtom goal()
end_variable
0
begin_state
1
1
1
1
1
1
1
1
1
1
1
1
1
1
end_state
begin_goal
1
13 0
end_goal
20
begin_operator
complete_DETDUP_complete__finish-EQ-finish 
2
11 1
12 0
1
0 13 -1 0
1
end_operator
begin_operator
context-emergency_type_DETDUP_context-emergency_type__set-complete-EQ-update-im 
2
11 1
0 0
2
0 1 1 0
0 2 1 0
1
end_operator
begin_operator
dialogue_statement_DETDUP_dialogue_statement__reset-EQ-lock 
0
1
0 11 0 1
1
end_operator
begin_operator
get-smoke_from_fire_DETDUP_get-smoke_from_fire__set-smoke-EQ-fallback 
2
3 1
2 0
1
0 11 1 0
1
end_operator
begin_operator
get-smoke_from_fire_DETDUP_get-smoke_from_fire__set-smoke-EQ-indicate_smoke_not_seen 
2
11 1
2 0
3
0 3 1 0
0 6 -1 0
0 5 -1 1
1
end_operator
begin_operator
get-smoke_from_fire_DETDUP_get-smoke_from_fire__set-smoke-EQ-indicate_smoke_seen 
2
11 1
2 0
2
0 3 1 0
0 5 -1 0
1
end_operator
begin_operator
need_further_help_fire_emergency_DETDUP_need_further_help_fire_emergency__set-complete-EQ-fallback 
1
6 0
1
0 11 1 0
1
end_operator
begin_operator
need_further_help_fire_emergency_DETDUP_need_further_help_fire_emergency__set-complete-EQ-update-need_further_help 
2
11 1
6 0
1
0 12 -1 0
1
end_operator
begin_operator
single_slot__fire_color_DETDUP_single_slot__fire_color__validate-slot-fill-EQ-fallback 
2
7 0
9 1
1
0 11 1 0
1
end_operator
begin_operator
single_slot__fire_color_DETDUP_single_slot__fire_color__validate-slot-fill-EQ-fill-slot 
1
7 0
2
0 11 1 0
0 9 1 0
1
end_operator
begin_operator
single_slot__location_DETDUP_single_slot__location__validate-slot-fill-EQ-fallback 
2
8 0
10 1
1
0 11 1 0
1
end_operator
begin_operator
single_slot__location_DETDUP_single_slot__location__validate-slot-fill-EQ-fill-slot 
1
8 0
2
0 11 1 0
0 10 1 0
1
end_operator
begin_operator
slot-fill__get-smoke_description_DETDUP_slot-fill__get-smoke_description__validate-slot-fill-EQ-fallback 
3
3 0
4 1
5 0
1
0 11 1 0
1
end_operator
begin_operator
slot-fill__get-smoke_description_DETDUP_slot-fill__get-smoke_description__validate-slot-fill-EQ-smoke_description_found 
3
11 1
3 0
5 0
1
0 4 1 0
1
end_operator
begin_operator
update-after_slot_fill_fire_emergency_location_color_driven_DETDUP_update-after_slot_fill_fire_emergency_location_color_driven__update-EQ-update 
3
11 1
9 0
10 0
1
0 0 -1 0
1
end_operator
begin_operator
update-context_smoke_DETDUP_update-context_smoke__set-context_known-EQ-set-all_context_known 
2
11 1
4 0
1
0 6 -1 0
1
end_operator
begin_operator
update-fire_emergency_location_color_driven_DETDUP_update-fire_emergency_location_color_driven__validate-slot-fill-more-EQ-fallback 
3
9 1
10 1
4 1
1
0 11 1 0
1
end_operator
begin_operator
update-fire_emergency_location_color_driven_DETDUP_update-fire_emergency_location_color_driven__validate-slot-fill-more-EQ-fire_color_found 
2
10 1
4 1
3
0 8 -1 0
0 11 1 0
0 9 1 0
1
end_operator
begin_operator
update-fire_emergency_location_color_driven_DETDUP_update-fire_emergency_location_color_driven__validate-slot-fill-more-EQ-fire_color_found-location_found 
2
11 1
4 1
2
0 9 1 0
0 10 1 0
1
end_operator
begin_operator
update-fire_emergency_location_color_driven_DETDUP_update-fire_emergency_location_color_driven__validate-slot-fill-more-EQ-location_found 
2
9 1
4 1
3
0 7 -1 0
0 11 1 0
0 10 1 0
1
end_operator
0
