extends Node

@onready var inventory_slot_scene = preload("res://Scenes/inventory_slot.tscn")
const INVENTORY_DATA : InventoryData = preload("res://Inventory Resources/player_inventory.tres")
const HOTBAR_INVENTORY : HotbarData = preload("uid://bvlgk6k7cl46g")


signal update_inventory
signal clear_inventory

signal player_position
signal player_character_id


signal continue_startup
signal sort
var times_rolled : int 

var inventory_timer = 3
var inventory_time = 0

const PLAYER = preload("res://Scenes/Player.tscn")
var player :  Player
var player_node: Node = null


var PlayerStars: Dictionary = {
	1 : 0,
	2 : 0,
	3 : 0,
	4 : 0
}



var PlayerPosition: Dictionary = {
	1 : 0, 
	2 : 0,
	3 : 0,
	4 : 0
}


 
var PlayerBucks: Dictionary = {
	1 : 0, 
	2 : 0,
	3 : 0,
	4 : 0
}



var PlayerMovement: Dictionary = {
	1 : true,
	2 : true,
	3 : true,
	4 : true
}

var Opponent: Dictionary = {
	1 : false,
	2 : false,
	3 : false,
	4 : false
}

var Set_Characters: Dictionary = {
	1 : "",
	2 : "",
	3 : "",
	4 : ""
}

@export_category("Board Dictionaries")
var initial_rolls : Dictionary = {
	1 : 0,
	2 : 0
}

var LastPosition: Dictionary = {
	1 : 0,
	2 : 0,
	3 : 0,
	4 : 0
}

var remaining_steps : Dictionary = {} 

var Turns : Dictionary = {}

var pending_branch : Dictionary = {}

var pending_branch_player = -1




@warning_ignore("shadowed_variable")
func set_player_reference(player):
	player_node = player


func _ready() -> void:
	inventory_time = inventory_timer
	



@warning_ignore("unused_parameter")
func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("hotbar_3"):
		#var playerid = randi_range(1, 2)
		#print(playerid)
		#var x = 100
		#var y = 100
		#player_position.emit(playerid, x, y)
	pass


func set_player_character(playerid: int, characterid: String):
	player_character_id.emit(playerid, characterid)
	Set_Characters[playerid] = characterid


func request_branch_choice(player_id: int, branches: Array[int]):
	pending_branch[player_id] = branches
	pending_branch_player = player_id
	
	print("Branch choice", player_id)
	for i in range(branches.size()):
		print(i + 1, "to spot", branches[i])
		
	#show_branch_ui(player_id, branches)



func startup_game():
	times_rolled += 1
	
	if times_rolled < 2:
		continue_startup.emit()
	else:
		sort.emit()



func set_player_position(playerid, x, y):
	player_position.emit(playerid, x, y)



func _process(delta: float) -> void:
	inventory_time -= delta
	
	if inventory_time <= 0:
		update_inventory.emit()
		await get_tree().create_timer(3).timeout
		clear_inventory.emit()
		inventory_time = inventory_timer



func freeze_player(player_id : int):
	PlayerMovement[player_id] = false

func unfreeze_player(player_id : int):
	PlayerMovement[player_id] = true
