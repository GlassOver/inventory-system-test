class_name Player extends CharacterBody2D



#region /// Onready Variables
@onready var inventory_ui: CanvasLayer = $InventoryUI
@onready var ui_interact: CanvasLayer = $InteractUI
@onready var inventory_hotbar: CanvasLayer = $InventoryHotbar

#endregion

#region /// Variables
var pSpeed = 200 
signal menu_shown
signal menu_hidden
#endregion

func _ready() -> void:
	Global.set_player_reference(self)

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * pSpeed
	
	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		
		get_tree().paused = !get_tree().paused
		if inventory_ui.visible == true:
			menu_shown.emit()
		elif inventory_ui.visible == false:
			menu_hidden.emit()
			
		inventory_hotbar.visible = !inventory_hotbar.visible
		
		
#region		### Unnecessary at the moment

#func use_hotbar_item(slot_index):
	#if slot_index < Global.hotbar_inventory.size():
		#var item = Global.hotbar_inventory[slot_index]
		#if item != null:
			#apply_item_effect(item)
			#item["quantity"] -= 1
			#if item["quantity"] <= 0:
				#Global.hotbar_inventory[slot_index] = null
				#Global.remove_item(item["type"], item["effect"])
			#Global.inventory_updated.emit()


#func _unhandled_input(event):
	#if event is InputEventKey and event.pressed:
		#for i in range(Global.hotbar_size):
			#
			#if Input.is_action_just_pressed("hotbar_" + str(i + 1)):
				#use_hotbar_item(i)
				#break

#Comment Comment Comment
#endregion
