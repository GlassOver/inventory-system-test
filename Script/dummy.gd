class_name Dummy extends CharacterBody2D

signal enemy_damaged(hurt_box : HurtBox)

@onready var hitbox: HitBox = $Hitbox
var maxhp = 115
var hp = 115

func _ready() -> void:
	hitbox.damaged.connect(_take_damage)


func _take_damage(hurt_box : HurtBox) -> void:	
	if hp > 0:
		var dmg : float = hurt_box.damage
		
		#if dmg > 0:
			#@warning_ignore("narrowing_conversion")
			#dmg = clampi(dmg - def - def_bonus, 1, dmg)
			
		@warning_ignore("narrowing_conversion")
		update_hp(-dmg)
		enemy_damaged.emit(hurt_box)
		
	else:
		print("Success!")



func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, maxhp)
	print("Enemy HP after update: ", hp)
