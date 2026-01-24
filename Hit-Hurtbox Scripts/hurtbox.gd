class_name HurtBox extends Area2D

@export var damage : int = 10
var stock_damage : int = 0
var affinities = {}
var hitbox_resistances = {}

signal did_damage

func _ready() -> void:
	area_entered.connect(AreaEntered)
	pass
	
func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		hitbox_resistances = a.resistances
		affinities = Global.INVENTORY_DATA.affinities
		calculate_full_damage()
		did_damage.emit()
		a.TakeDamage(self)
		damage = stock_damage
	pass

func calculate_full_damage():
	var dmg := damage

	for element in affinities:
		var affinity_value = affinities[element]
		var resistance = hitbox_resistances.get(element, 1.0)
		dmg += affinity_value * resistance

	stock_damage = damage
	damage = dmg
	print(damage)

#Note, when dealing with negative values the negative damage stacks.
#eg. If your first attack does 20 damage, it can slowly increase and do -300 damage
#this would be fine if it wasn't stacking. Need to solve this

#It looks like damage is stacking regardless. 
#This is probably because I'm setting damage to = dmg. So that when
#the loop runs back again it uses my already-enhanced value. 
