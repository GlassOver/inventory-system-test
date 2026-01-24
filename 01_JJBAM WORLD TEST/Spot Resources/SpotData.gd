class_name SpotData extends Resource 

@export var texture : Texture2D

@export_category("Spot Effects")
@export var effects : Array[SpotTypeData]


func use(player_id) -> bool:
	if effects.size() == 0:
		return false
	
	for e in effects:
		e.use(player_id)
	return true
