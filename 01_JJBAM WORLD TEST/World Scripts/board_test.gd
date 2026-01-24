class_name Board extends Node2D

const SPOT = preload("uid://ctdo03q80aarc")
var spot : Spot
const DICE = preload("uid://cogapd6mhf6fh")
var dice : Dice


@export var ContainedSpots : Array [SpotData]
@onready var spot_nodes: Node = $Spots
@onready var spots: Array[Node] = $Spots.get_children()

var mincount

var remaining_steps : Dictionary = {
	
} 


var Spot_Pos : Dictionary = {
	
}

var Spot_By_Index : Dictionary = {
	
}

var initial_turns : Dictionary = {
	1 : 1,
	2 : 2
}

# -1
# 0



func _ready() -> void:
	initialize_spots()
	Global.continue_startup.connect(initial_game_startup)
	Global.sort.connect(begin_turn_sorting)
	set_players(1)
	set_players(2)



func set_players(player_id):
	var pos = get_old_player_spot_position(player_id)
	var x = pos.x
	var y = pos.y
	Global.set_player_position(player_id, x, y)



func get_old_player_spot_position(player_id) -> Vector2:
	var spot_index = Global.PlayerPosition[player_id]
	var real_index = spot_index - 1
	
	if real_index == null:
		return Vector2.ZERO
	
	if not Spot_Pos.has(real_index):
		return Vector2.ZERO
	
	return Spot_Pos[real_index]



func initial_game_startup():
	var player_id : int
	dice = DICE.instantiate() as Dice
	add_child(dice)
	
	dice.initialRolls = true

	for key in initial_turns.keys():
		initial_turns[key] -= 1
		
		if initial_turns[key] == 0:
			player_id = key
			dice.get_current_player(player_id)
			print(Global.times_rolled)
			pass



func begin_turn_sorting():
	var count = 0
	var sorted_turns = Global.initial_rolls.keys()
	print("sort checked")
	dice.initialRolls = false
	dice.queue_free()
	
	sorted_turns.sort_custom(func(a, b):
		return Global.initial_rolls[a] > Global.initial_rolls[b])
	
	for key in sorted_turns:
		count += 1
		Global.Turns[key] = 0 + count



func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("debug_1"):
		initial_game_startup()
	
	if event.is_action_pressed("debug_2"):
		begin_turns()
	
	if Global.pending_branch_player == -1:
		return


	if event is InputEventKey and event.pressed:
		var key = event.keycode
		
		if key >= KEY_1 and key <= KEY_9:
			var choice_index = key - KEY_1
			
			var branches = Global.pending_branch[Global.pending_branch_player]
			if choice_index < branches.size():
				resolve_branch(Global.pending_branch_player, branches[choice_index])





func begin_turns():
	var player_id : int
	dice = DICE.instantiate() as Dice
	add_child(dice)
	
	for key in Global.Turns.keys():
		Global.Turns[key] -= 1
		if Global.Turns[key] == 0:
			player_id = key
			Global.Turns[key] += 2
			dice.get_current_player(player_id)
			Global.LastPosition[player_id] = Global.PlayerPosition[player_id]
			mincount = Global.LastPosition[player_id]
			dice.player_move.connect(spot_by_spot)



func initialize_spots():
	var count : int = min(spots.size(), ContainedSpots.size())
	
	for i in range(count):
		var spotnode = spots[i]
		var spotdata = ContainedSpots[i]
		
		spot = SPOT.instantiate() as Spot
		add_child(spot)
		
		spot.global_position = spotnode.global_position
		spot._set_spot_data(spotdata)
		
		Spot_By_Index[i] = spot
		Spot_Pos[i] = spotnode.global_position



func spot_by_spot(player_id):
	var count = Global.PlayerPosition[player_id]
	var pos = get_player_spot_position(player_id)
	

	Global.set_player_position(player_id, pos.x, pos.y)
	
	await get_tree().create_timer(0.4).timeout
	
	check_for_crossroads(player_id)
	if Global.pending_branch_player == player_id:
		return
	
	if mincount < count:
		spot_by_spot(player_id)
		
	elif mincount == count:
		mincount = 0
		spot_function(player_id)



func check_for_crossroads(player_id):
	var spot_index = mincount
	var realspot = spot_index - 1
	if not Spot_By_Index.has(realspot):
		return
	
	var _spot = Spot_By_Index[realspot]
	var spot_type = _spot.spot_data.effects
	
	for effect in spot_type:
		if effect is SpotCrossroad:
			effect.use(player_id)
			break
	
	
	
func resolve_branch(player_id: int, chosen_index: int):
	if not Global.pending_branch.has(player_id):
		return

	Global.pending_branch.erase(player_id)
	Global.pending_branch_player = -1

	Global.PlayerPosition[player_id] = chosen_index
	mincount = chosen_index
	spot_by_spot(player_id)



func get_player_spot_position(player_id) -> Vector2:
	player_id = player_id
	var spot_index = mincount
	
	if spot_index == null:
		return Vector2.ZERO
		
	if not Spot_Pos.has(spot_index):
		return Vector2.ZERO
	
	mincount += 1
	return Spot_Pos[spot_index]



func spot_function(player_id):
	var spot_index = Global.PlayerPosition[player_id]
	var realspot = spot_index - 1
	if Spot_By_Index.has(realspot):
		Spot_By_Index[realspot].spot_data.use(player_id)

	pass
