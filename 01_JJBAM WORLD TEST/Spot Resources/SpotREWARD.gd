class_name SpotReward extends SpotTypeData

@export var coins_reward : int = 1
@export var stars_reward : int = 1

func use(player_id):
	Global.PlayerBucks[player_id] += coins_reward
	print("Reward")
	print(Global.PlayerBucks[player_id])
	pass
