extends CharacterBody2D

#region /// Onready Variables
@onready var inventory_ui: CanvasLayer = $InventoryUI
@onready var ui_interact: CanvasLayer = $InteractUI
@onready var inventory_hotbar: CanvasLayer = $InventoryHotbar

#endregion

#region /// Variables
var pSpeed = 200 
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
		#inventory_hotbar.visible = !inventory_hotbar.visible
		
		
#func apply_item_effect(item):
	#match item["effect"]:
		#"Stamina": 
			#pSpeed += int(item["bonus"])
			#print("Speed increased to", pSpeed)
	#
		#"Slot Boost": 
			#Global.increase_inventory_size(int(item["bonus"]))
			#print("Slots increased to", Global.inventory.size())


		#_:
			#print("No effect")


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
