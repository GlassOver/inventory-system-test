class_name HotbarData extends Resource

@export var slots : Array[SlotData]


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	connect_slots()

func add_item(item : ItemData, count : int = 1) -> bool:
	for s in slots:
		if s != null:
			if s.item_data == item:
				s.quantity += count
				return true
				
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			new.changed.connect(slot_changed)
			return true
	
	print("Inventory was full!")
	return false


func remove_hotbar_item(item : ItemData):
	for i in slots.size():
		if slots[i] != null:
			if slots[i] == item:
				if slots[i].quantity <= 0:
					slots[i] = null
				emit_changed()
				return true
	return false
	
#func remove_hotbar_item(item_type, item_effect):
	#for i in range(hotbar_inventory.size()):
		#if hotbar_inventory[i] != null and hotbar_inventory[i]["type"] == item_type and hotbar_inventory[i]["effect"] == item_effect:
			#if hotbar_inventory[i]["quantity"] <= 0:
				#hotbar_inventory[i] = null
			#inventory_updated.emit()
			#return true
	#return false




func connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(slot_changed)

func slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(slot_changed)
				var index = slots.find(s)
				slots[index] = null
				emit_changed()
	pass

##I'm not totally sure what this function is meant to do?
##It was in the original hotbar code which worked, but I can't
##Translate it properly into Michael's code.
func is_item_assigned_to_hotbar(item_to_check):
	return item_to_check in slots
	
#func is_item_assigned_to_hotbar(item_to_check):
	#return item_to_check in hotbar_inventory
