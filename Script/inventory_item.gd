@tool
extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var item_data : ItemData : set = _set_item_data



func _ready() -> void:
	_update_texture()
	
	if Engine.is_editor_hint():
		return
		
	area_2d.body_entered.connect(_on_body_entered)


func _on_body_entered(b) -> void:
	if b.is_in_group("Player"):
		if item_data:
			if Global.INVENTORY_DATA.add_item(item_data) == true:
				pickup_item()
		
	pass



func pickup_item() -> void:
	area_2d.body_entered.disconnect(_on_body_entered)
	queue_free()
	


func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()

##func set_item_data(data):
	##item_type = data["type"]
	##item_name = data["name"]
	##item_effect = data["effect"]
	##effect_bonus = data["bonus"]
	##item_texture = data["texture"]



func _update_texture() -> void:
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
