@tool
extends Node2D
#
#@onready var icon_sprite = $Sprite2D
#var scene_path: String = "res://Scenes/InventoryItem.tscn"
#var player_detected = false
#
##region /// Item properties
#@export var item_type = ""
#@export var item_name = ""
#@export var item_effect = ""
#@export var effect_bonus = ""
#@export var item_texture: Texture
##endregion



#func _ready() -> void:
	#if not Engine.is_editor_hint():
		#icon_sprite.texture = item_texture




#func _process(_delta: float) -> void:
	#if Engine.is_editor_hint():
		#icon_sprite.texture = item_texture
	#
	#if player_detected and Input.is_action_just_pressed("ui_add"):
		#pickup_item()
#
#
#func pickup_item():
	#var item = {
		#"quantity" : 1,
		#"type" : item_type,
		#"name" : item_name,
		#"effect" : item_effect,
		#"bonus" : effect_bonus,
		#"texture" : item_texture,
		#"scene_path" : scene_path
	#}
	#if Global.player_node:
		#Global.add_item(item, false)
		#self.queue_free()
		#
#
#
#func _on_area_2d_body_entered(body):
	#if body.is_in_group("Player"):
		#print("Entered")
		#player_detected = true
		#body.ui_interact.visible = true
	#
#func _on_area_2d_body_exited(body):
	#if body.is_in_group("Player"):
		#player_detected = false
		#body.ui_interact.visible = false
	#
#
#func set_item_data(data):
	#item_type = data["type"]
	#item_name = data["name"]
	#item_effect = data["effect"]
	#effect_bonus = data["bonus"]
	#item_texture = data["texture"]
#
#func initiate_items(type, name, effect, bonus, texture):
	#item_type = type
	#item_name = name
	#item_effect = effect
	#effect_bonus = bonus
	#item_texture = texture
