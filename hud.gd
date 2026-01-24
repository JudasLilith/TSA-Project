extends CanvasLayer

# Defines signal (like var) to use later
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreLabel.hide()
	
func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$MessageTimer.start()	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_game_over():
	$ScoreLabel.hide()
	$Message.text = str("You got infected!")
	$Message.show()
	# Wait until the MessageTimer has counted down.
	$StartButton.text = "Try again"
	$StartButton.show()
	
func show_game_end():
	$ScoreLabel.hide()
	$Message.text = str("You survived!")
	$Message.show()
	# Wait until the MessageTimer has counted down.
	$StartButton.text = "Next level"
	$StartButton.show()
	#get_tree().change_scene_to_file("res://level_2.tscn")
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
