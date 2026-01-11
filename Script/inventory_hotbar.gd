class_name HotbarUI extends Control

const INVENTORY_SLOT = preload("uid://dpdkxjw467dip")

@onready var hotbar_container: HBoxContainer = $HBoxContainer
@export var data : HotbarData


func _ready():
	await get_tree().create_timer(0.2).timeout
	Global.player_node.menu_hidden.connect(_on_inventory_updated)
	Global.player_node.menu_shown.connect(clear_grid_container)
	data.changed.connect(on_inventory_changed)
	pass



func _on_inventory_updated():
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		hotbar_container.add_child(new_slot)
		new_slot.slot_data = s




func clear_grid_container():
	while hotbar_container.get_child_count() > 0:
		var child = hotbar_container.get_child(0)
		hotbar_container.remove_child(child)
		child.queue_free()	
	


func on_inventory_changed() -> void:
	clear_grid_container()
	_on_inventory_updated()
