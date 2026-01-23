extends Label

@onready var timer = get_node("/root/Level1/ScoreTimer") 

func _process(_delta):
	if timer.time_left > 0:
		text = str(int(timer.time_left))
	else:
		text = "5"
