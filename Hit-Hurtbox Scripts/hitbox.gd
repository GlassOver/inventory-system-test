class_name HitBox extends Area2D

signal damaged(hurt_box : HurtBox)
signal star_pickup

@export var resistances: Dictionary = {
	"FIREPOT": 1.0,
	"ICEPOT": 1.0,
	"SUNPOT": 1.0,
	"NIGHTPOT": 1.0,
	"LIFEPOT": 1.0,
	"DEATHPOT": 1.0
}

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		TakeDamage(area)
	if area is StarPickup:
		star_pickup.emit()


func TakeDamage(hurt_box : HurtBox) -> void:
	damaged.emit(hurt_box)
