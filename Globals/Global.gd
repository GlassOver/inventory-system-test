extends Node

@onready var inventory_slot_scene = preload("res://Scenes/inventory_slot.tscn")
const INVENTORY_DATA : InventoryData = preload("res://Inventory Resources/player_inventory.tres")
signal update_inventory
signal clear_inventory
var inventory_timer = 3
var inventory_time = 0

const PLAYER = preload("res://Scenes/Player.tscn")
var player :  Player
var player_node: Node = null



func set_player_reference(player):
	player_node = player

func _ready() -> void:
	inventory_time = inventory_timer
	
func _process(delta: float) -> void:
	inventory_time -= delta
	
	if inventory_time <= 0:
		update_inventory.emit()
		await get_tree().create_timer(3).timeout
		clear_inventory.emit()
		inventory_time = inventory_timer
