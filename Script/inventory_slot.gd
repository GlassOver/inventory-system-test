class_name InventorySlotUI extends Control

@onready var item_icon: Sprite2D = $InnerBorder/ItemIcon
@onready var item_quantity: Label = $InnerBorder/ItemQuantity
@onready var details_panel: ColorRect = $DetailsPanel
@onready var item_name: Label = $DetailsPanel/ItemName
@onready var item_type: Label = $DetailsPanel/ItemType
@onready var item_effect: Label = $DetailsPanel/ItemEffect
@onready var usage_panel: ColorRect = $UsagePanel
@onready var assign_button: Button = $UsagePanel/AssignButton
@onready var item_button: Button = $ItemButton
@onready var item_desc: Label = $CanvasLayer2/ItemDesc
@onready var use_button: Button = $UsagePanel/UseButton

var slot_data : SlotData : set = set_item

#Slot item
var item = null
var slot_index = -1
var is_assigned = false




func _ready() -> void:
	item_icon.texture = null
	item_quantity.text = ""
	item_button.focus_entered.connect(item_focused)
	item_button.focus_exited.connect(item_unfocused)
	item_button.pressed.connect(toggle_usage_panel)
	assign_button.pressed.connect(assign_to_hotbar)
	
	


func set_item(value : SlotData):
	slot_data = value
	if slot_data == null:
		return
	item_icon.texture = slot_data.item_data.texture
	item_quantity.text = str(slot_data.quantity)
	
	item_name.text = str(slot_data.item_data.name)
	item_type.text = str(slot_data.item_data.quality)
	
	
	
func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			update_item_description(slot_data.item_data.description)
	pass


func item_unfocused() -> void:
	update_item_description("")


func update_item_description(new_text : String) -> void:
	item_desc.text = new_text



func toggle_usage_panel():
	if slot_data != null:
		if slot_data.item_data != null:
			usage_panel.visible = !usage_panel.visible



func _on_use_button_pressed() -> void:
	usage_panel.visible = false
	if slot_data: 
		if slot_data.item_data:
			var was_used = slot_data.item_data.use()
			if was_used == false:
				return
			slot_data.quantity -= 1
			item_quantity.text = str(slot_data.quantity)



## When the assigned button is pressed, it should (and does) append
## The selected item into the hotbar array.
## If it's already assigned, it should remove the item from the hotbar
## It doesn't currently remove items from the hotbar.
func assign_to_hotbar() -> void:
	if slot_data:
		if slot_data.item_data:
			if is_assigned:
				Global.HOTBAR_INVENTORY.remove_hotbar_item(slot_data.item_data)
				is_assigned = false
			else:
				var _item = slot_data.item_data
				var count = int(slot_data.quantity)
				Global.HOTBAR_INVENTORY.add_item(_item, count)
				is_assigned = true
			update_assignment_status()


## This function should change the status of the item, but I'm
## Not sure if it's working properly. At the very least I've noticed
## That if you press assign in the inventory it WILL change the "Assign"
## Text to "Unassign" but it won't change the text back if you press
## it again. It WILL reset if you reopen the inventory though. 

func update_assignment_status():
	is_assigned = Global.HOTBAR_INVENTORY.is_item_assigned_to_hotbar(item)
	if is_assigned:
		assign_button.text = "Unassign"
	else:
		assign_button.text = "Assign"
	pass
