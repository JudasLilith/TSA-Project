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
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	restart()
	
func show_game_end():
	show_message("You Survived!")
	await $MessageTimer.timeout
	get_tree().change_scene_to_file("res://level_2.tscn")

func restart():
	$Message.text = "Survive from the Bacteria!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	if score <= 0:
		show_game_end()
		return 
	$ScoreLabel.text = str(score)
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
	
