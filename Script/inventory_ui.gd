class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("uid://dpdkxjw467dip")

@onready var grid_container: GridContainer = $GridContainer
@export var data : InventoryData

func _ready():
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()


func _on_inventory_updated():
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		grid_container.add_child(new_slot)
		new_slot.slot_data = s
	get_child(0).grab_focus()
	
	##clear_grid_container()
	##for item in Global.inventory:
		##var slot = Global.inventory_slot_scene.instantiate()
		##grid_container.add_child(slot)
		##if item != null:
			##slot.set_item(item)
		##else:
			##slot.set_empty()


func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
