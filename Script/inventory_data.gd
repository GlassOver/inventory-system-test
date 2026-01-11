class_name InventoryData extends Resource

@export var slots : Array[SlotData]
var is_assigned = false



func _init() -> void:
	connect_slots()
	pass


func add_item(item : ItemData, count : int = 1) -> bool:
	is_assigned = Global.HOTBAR_INVENTORY.is_item_assigned_to_hotbar(item)
						###This part should check if the item has the is_assigned variable checked to true
	for s in slots:
		if s != null:
			if s.item_data == item:
				if is_assigned:
					Global.HOTBAR_INVENTORY.add_item(item)
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
	
#func add_item(item, to_hotbar = false):
	#var added_to_hotbar = false
	#
	#if to_hotbar:
		#added_to_hotbar = add_hotbar_item(item)
		#inventory_updated.emit()
		#
	#if not added_to_hotbar:
		#for i in range(inventory.size()):
			#if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
				#inventory[i]["quantity"] += item["quantity"]
				#inventory_updated.emit()
				#return true
			#elif inventory[i] == null:
				#inventory[i] = item
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
