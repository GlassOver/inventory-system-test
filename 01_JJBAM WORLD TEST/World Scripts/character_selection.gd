extends Control

@onready var p1_selection: TextureRect = %P1Selection
@onready var grid_container: GridContainer = %GridContainer
@onready var p2_selection: TextureRect = %P2Selection
@onready var p1_label: Label = %P1Label
@onready var p2_label: Label = %P2Label

var player1SelectionIndex: int = 1 
var player2SelectionIndex: int = 2

var player1Character : RosterCharacter
var player2Character : RosterCharacter


func _ready() -> void:
	_refresh_selection()
	
	
func _refresh_selection():
	for child in grid_container.get_children():
		child.reset()
		
	var startContainerP1 = grid_container.get_child(player1SelectionIndex)
	var startContainerP2 = grid_container.get_child(player2SelectionIndex)
	
	startContainerP1.set_player_selection(CharacterSelectionBox.PlayerEnum.PLAYER1)
	p1_selection.texture = startContainerP1.get_character().texture
	p1_label.text = startContainerP1.get_character().name
	
	startContainerP2.set_player_selection(CharacterSelectionBox.PlayerEnum.PLAYER2)
	p2_selection.texture = startContainerP2.get_character().texture
	p2_label.text = startContainerP2.get_character().name

	
func _process(_delta: float) -> void:
	
	var player1Direction = Input.get_vector("p1_move_left", "p1_move_right", "p1_move_up", "p1_move_down", 0.5).round()
	var player2Direction = Input.get_vector("p2_move_left", "p2_move_right", "p2_move_up", "p2_move_down", 0.5).round()
	
	if not player1Character:
		player1SelectionIndex = _get_selection_index(player1SelectionIndex, player1Direction)
		
	if not player2Character:
		player2SelectionIndex = _get_selection_index(player2SelectionIndex, player2Direction)
		
	_refresh_selection()
	


func _input(event: InputEvent) -> void:
	var startContainerP1 = grid_container.get_child(player1SelectionIndex)
	var startContainerP2 = grid_container.get_child(player2SelectionIndex)
	
	if event.is_action_pressed("p1_interact"):
		Global.set_player_character(1, startContainerP1.get_character().character_id)
		get_tree().change_scene_to_file("res://01_JJBAM WORLD TEST/Scenes/board_test.tscn")
	
	if event.is_action_pressed("p2_interact"):
		Global.set_player_character(2, startContainerP2.get_character().character_id)



func _get_selection_index(currentIndex: int, direction: Vector2i):
	var index: int = currentIndex
	
	if direction.x:
		index = currentIndex + direction.x
		
	if direction.y:
		index = currentIndex + direction.y * grid_container.columns
		
	var selectedContainer = grid_container.get_child(index)
	if selectedContainer and selectedContainer.selectable and not selectedContainer.selected:
		return index
	else:
		return currentIndex


func _check_selection_done():
	if player1Character and player2SelectionIndex:
		pass
