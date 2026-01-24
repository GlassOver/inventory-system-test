class_name EquipableItemAffinities extends Resource

enum Affinity { FIREPOT, LIFEPOT, SUNPOT, DEATHPOT, ICEPOT, 
NIGHTPOT }
#Special types of armor that limits growth to a specific stat.  
#Special types of effects, like doubling spells, lingering attacks/extra attacks
#Armor that increases or decreases your equipment slots.

@export var affinity : Affinity = Affinity.SUNPOT
@export var value : int = 1
