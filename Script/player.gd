class_name Player extends CharacterBody2D

@export var controls : Resource = null
@export var cutscene = false
@export var character_id = null

#region /// Onready Variables
@onready var inventory_ui: CanvasLayer = $InventoryUI
@onready var ui_interact: CanvasLayer = $InteractUI
@onready var inventory_hotbar: CanvasLayer = $InventoryHotbar
@onready var hitbox: Area2D = $Hitbox
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#endregion

#region /// Variables
var player_id = null
var maxhp = 20
var hp = 20
var strength = 10
var pSpeed = 200 
signal menu_shown
signal menu_hidden
#endregion

#region /// Signals
signal player_damaged(hurt_box: HurtBox)
signal identify_self
#endregion


func _ready() -> void:
	hitbox.damaged.connect(_take_damage)
	Global.set_player_reference(self)
	Global.player_position.connect(_change_position)
	Global.player_character_id.connect(set_character)
	player_id = controls.player_index
	set_character(player_id, Global.Set_Characters[player_id])



func set_character(player, character) -> void:
	if player_id == player:
		character_id = character
		sprite_2d.play(character_id + "_f_walk")



#(1, 100, 100)
func _change_position(player, x, y):
	if player_id == player:
		self.global_position.x = x
		self.global_position.y = y
	pass


func _emit_self():
	identify_self.emit(player_id)



func get_input():
	var input_direction = Input.get_vector(controls.move_left, controls.move_right, controls.move_up, controls.move_down)
	if Global.PlayerMovement[player_id] == true:
		velocity = input_direction * pSpeed
	else:
		velocity = input_direction * 0
		print(Global.PlayerMovement)
	
	
	
func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	
	
	
func _input(event: InputEvent) -> void:
	#if event.is_action_pressed(controls.interact):
		#Global.freeze_player(player_id)
		#update_damage_values()
		
		
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		
		get_tree().paused = !get_tree().paused
		if inventory_ui.visible == true:
			menu_shown.emit()
		elif inventory_ui.visible == false:
			menu_hidden.emit()
			
		inventory_hotbar.visible = !inventory_hotbar.visible
		
		
		
func _take_damage(hurt_box : HurtBox) -> void:	
	if hp > 0:
		var dmg : float = hurt_box.damage
		
		#if dmg > 0:
			#@warning_ignore("narrowing_conversion")
			#dmg = clampi(dmg - def - def_bonus, 1, dmg)
			
		@warning_ignore("narrowing_conversion")
		update_hp(-dmg)
		player_damaged.emit(hurt_box)
		
	else:
		player_damaged.emit(hurt_box)
		update_hp(9999)
	pass	



func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, maxhp)
	print("Player HP after update: ", hp)
	
	
	
func update_damage_values() -> void:
	Global.INVENTORY_DATA.get_weapon_affinity()
	var damage_value : int = strength + Global.INVENTORY_DATA.get_attack_bonus()
	var affinity_list = Global.INVENTORY_DATA.affinities
	print(damage_value)
	print(affinity_list)
	$Hurtbox.damage = damage_value
	
	
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
