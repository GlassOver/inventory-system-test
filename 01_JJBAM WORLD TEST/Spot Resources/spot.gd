@tool
class_name Spot extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

@export var spot_data : SpotData : set = _set_spot_data
@export var next_spots : Array[int] = []



func _ready() -> void:
	_update_texture()
	
	if Engine.is_editor_hint():
		return



func _set_spot_data(value : SpotData) -> void:
	spot_data = value
	_update_texture()



func _update_texture() -> void:
	if spot_data and sprite_2d:
		sprite_2d.texture = spot_data.texture
	pass
