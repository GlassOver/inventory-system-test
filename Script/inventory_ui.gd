class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("uid://dpdkxjw467dip")

@onready var grid_container: GridContainer = $GridContainer
@export var data : InventoryData



func _ready():
	await get_tree().create_timer(0.2).timeout
	Global.player_node.menu_shown.connect(_on_inventory_updated)
	Global.player_node.menu_hidden.connect(clear_grid_container)
	data.changed.connect(on_inventory_changed)
	pass



func _on_inventory_updated():
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		grid_container.add_child(new_slot)
		new_slot.slot_data = s



func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()	
	
	
	
func on_inventory_changed() -> void:
	clear_grid_container()
	_on_inventory_updated()
