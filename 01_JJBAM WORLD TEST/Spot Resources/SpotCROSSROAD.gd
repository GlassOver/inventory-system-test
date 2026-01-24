class_name SpotCrossroad extends SpotTypeData

@export var branches : Array[int] = []

func use(player_id):
	if branches.is_empty():
		return

	Global.request_branch_choice(player_id, branches)
