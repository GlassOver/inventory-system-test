class_name InventorySlotUI extends Control

@onready var item_icon: Sprite2D = $InnerBorder/ItemIcon
@onready var item_quantity: Label = $InnerBorder/ItemQuantity
@onready var details_panel: ColorRect = $DetailsPanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_type: Label = $DetailsPanel/ItemType
@onready var item_effect: Label = $DetailsPanel/ItemEffect
@onready var usage_panel: ColorRect = $UsagePanel
@onready var assign_button: Button = $UsagePanel/AssignButton

var _slot_data: SlotData = null
var slot_data: SlotData:
	get:
		return _slot_data
	set(value):
		set_item(value)

#Slot item
var item = null
var slot_index = -1
var is_assigned = false

func _ready() -> void:
	item_icon.texture = null
	item_quantity.text = ""


func set_item(value : SlotData):
	_slot_data = value
	if _slot_data == null:
		return
	item_icon.texture = _slot_data.item_data.texture
	item_quantity.text = str(_slot_data.quantity)
	
	item_name.text = str(_slot_data.item_data.name)
	item_type.text = str(_slot_data.item_data.quality)
	
	#if item["effect"] != "":
		#item_effect.text = str("+ ", item["effect"])
	#else:
		#item_effect.text = ""
	#update_assignment_status()
	

func _on_item_button_pressed() -> void:
	print("Pressed item")
	if slot_data != null:
		usage_panel.visible = !usage_panel.visible


func _on_item_button_mouse_entered() -> void:
	print("Hovering item")
	if slot_data != null:
		usage_panel.visible = false
		details_panel.visible = true

func _on_item_button_mouse_exited() -> void:
	print("Exiting hover")
	details_panel.visible = false

#func _on_use_button_pressed() -> void:
	#usage_panel.visible = false
	#if item != null and item["effect"] != "":
		#if Global.player_node:
			#Global.player_node.apply_item_effect(item)
			#Global.remove_item(item["type"], item["effect"])
			#Global.remove_hotbar_item(item["type"], item["effect"])
			#
		#else:
			#print("Player could not be found.")


#func update_assignment_status():
	#is_assigned = Global.is_item_assigned_to_hotbar(item)
	#if is_assigned: 
		#assign_button.text = "Unassign"
	#else:
		#assign_button.text = "Assign"
#
#
#func _on_assign_button_pressed() -> void:
	#if item != null:
		#if is_assigned:
			#Global.unassign_hotbar_item(item["type"], item["effect"])
			#is_assigned = false
		#else:
			#Global.add_item(item, true)
			#is_assigned = true
		#update_assignment_status()
