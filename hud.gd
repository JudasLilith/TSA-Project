extends CanvasLayer

# Defines signal (like var) to use later
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.show()
	$Sprite2D.show()
	$"/root/Level1/player".input_enabled = false
	
func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$MessageTimer.start()	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func show_game_over():
	$ScoreLabel.hide()
	$Sprite2D.show()
	$Sprite2D.texture = load("res://art/Msg-You Got Infected.png")
	$StartButton.icon = load("res://art/Btn-Try Again.png")
	$StartButton.show()
	
func show_game_end():
	$ScoreLabel.hide()
	$Sprite2D.show()
	$Sprite2D.texture = load("res://art/Msg-You Survived.png")
	$StartButton.icon = load("res://art/Btn-Next Level.png")
	$StartButton.show()
	#get_tree().change_scene_to_file("res://level_2.tscn")
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
