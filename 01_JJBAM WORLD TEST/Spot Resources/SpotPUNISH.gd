class_name SpotPunish extends SpotTypeData

@export var coins_take : int = 1
@export var stars_take : int = 1

func use(player_id):
	Global.PlayerBucks[player_id] -= coins_take
	print("Punish")
	print(Global.PlayerBucks[player_id])
	pass
