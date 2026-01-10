class_name HotbarUI extends Control

const INVENTORY_SLOT = preload("uid://dpdkxjw467dip")

@export var data : InventoryData
@onready var hotbar_container: HBoxContainer = $HBoxContainer



func _ready():
	await get_tree().create_timer(0.2).timeout
	Global.player_node.menu_hidden.connect(_on_inventory_updated)
	Global.player_node.menu_shown.connect(clear_grid_container)
	data.changed.connect(on_inventory_changed)
	pass

#func _ready():
	#Global.inventory_updated.connect(update_hotbar_ui)
	#update_hotbar_ui()


func _on_inventory_updated():
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		hotbar_container.add_child(new_slot)
		new_slot.slot_data = s

#func update_hotbar_ui():
	#clear_hotbar_container()
	#for i in range(Global.hotbar_size):
		#var slot = Global.inventory_slot_scene.instantiate()
		#slot.set_slot_index(i)
		#hotbar_container.add_child(slot)
		#if Global.hotbar_inventory[i] != null:
			#slot.set_item(Global.hotbar_inventory[i])
		#else:
			#slot.set_empty()
		#slot.update_assignment_status()


func clear_grid_container():
	while hotbar_container.get_child_count() > 0:
		var child = hotbar_container.get_child(0)
		hotbar_container.remove_child(child)
		child.queue_free()	
	
#func clear_hotbar_container():
	#while hotbar_container.get_child_count() > 0:
		#var child = hotbar_container.get_child(0)
		#hotbar_container.remove_child(child)
		#child.queue_free()	
	
	
	
func on_inventory_changed() -> void:
	clear_grid_container()
	_on_inventory_updated()
