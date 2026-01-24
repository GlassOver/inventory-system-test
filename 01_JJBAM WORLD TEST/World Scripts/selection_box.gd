class_name CharacterSelectionBox extends Control

@export var selectable : bool = true
@export var character: RosterCharacter

@onready var p1_texture: TextureRect = $P1Texture
@onready var p2_texture: TextureRect = $P2Texture

enum PlayerEnum {NONE, PLAYER1, PLAYER2}

var selected = false

func _ready() -> void:
	p1_texture.hide()
	p2_texture.hide()

func set_player_selection(player: PlayerEnum):
	if player == PlayerEnum.PLAYER1:
		selected = true
		p1_texture.show()
	elif player == PlayerEnum.PLAYER2:
		selected = true
		p2_texture.show()

func get_character():
	return character
	
func reset():
	selected = false
	p1_texture.hide()
	p2_texture.hide()
