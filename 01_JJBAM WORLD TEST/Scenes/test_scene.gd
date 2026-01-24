extends Node2D


# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_2"):
		get_tree().change_scene_to_file("res://01_JJBAM WORLD TEST/Scenes/board_test.tscn")
