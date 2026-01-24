class_name Dice extends StaticBody2D

@onready var faces: Node2D = $Faces
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var label: Label = $Label

signal roll_done
signal player_move

var initialRolls = false


var isRolling = false
var currentIndex = 0

var currentPlayer : String
var playerIndex : int

func _ready() -> void:
	_set_start_face()
	roll_done.connect(_on_roll_done)
	
	label.text = ""
	
	
	
func _set_start_face():
	for face in faces.get_children():
		face.hide()
		
	faces.get_child(0).show()
	
	
	
func get_current_player(player_index):
	if player_index == 1:
		currentPlayer = "p1_"
	if player_index == 2:
		currentPlayer = "p2_"
	if player_index == 3:
		currentPlayer = "p3_"
	if player_index == 4:
		currentPlayer = "p4_"
	
	playerIndex = player_index



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(currentPlayer+"interact"):
		_roll_dice()



func _roll_dice():
	var duration = 1.0
	isRolling = true
	label.text = ""
	
	while duration > 0:
		var newIndex = faces.get_children().pick_random().get_index()
		faces.get_child(currentIndex).hide()
		faces.get_child(newIndex).show()
		
		await get_tree().create_timer(0.1).timeout
		
		currentIndex = newIndex
		duration -= 0.1
		
	isRolling = false
	
	roll_done.emit(currentIndex + 1)



func _on_roll_done(index : int):
	
	if initialRolls == true:
		label.text = str(index)
		Global.initial_rolls[playerIndex] = index
		await get_tree().create_timer(2).timeout
		Global.startup_game()
		self.queue_free()
	else:
		label.text = str(index)
		Global.remaining_steps[playerIndex] = index
		Global.PlayerPosition[playerIndex] += index
		await get_tree().create_timer(2).timeout
		player_move.emit(playerIndex)
		self.queue_free()
