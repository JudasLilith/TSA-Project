extends CanvasLayer
class_name hud

const LEVELS = 3
static var level
signal start_game

func _ready():
	level = get_tree().current_scene.scene_file_path.get_file().get_basename()[-1] # Stores last char of scene name (level num)
	show()
	$ScoreLabel.hide()
	$Message.hide()
	$NextButton.hide()
	$RestartButton.hide()
	$StartButton.show()
	$Sprite2D.show()
	$ColorRect.show()
	$"/root/Level/player".input_enabled = false
	if level != "1":
		start_game.emit()
	else:
		$"/root/Level/fade_transition".show()
		$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	
func show_message(text):
	$Message.text = str(text)
	$Message.show()
	$ColorRect.show()
	$MessageTimer.start()	

func show_game_over():
	$ScoreLabel.hide()
	$Sprite2D.texture = load("res://art/Msg-You Got Infected.png")
	$Sprite2D.show()
	$ColorRect.show()
	$StartButton.icon = load("res://art/Btn-Try Again.png")
	$StartButton.show()
	$"/root/Level/fade_transition".show()
	$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	
func show_game_end():
	$ScoreLabel.hide()
	$Sprite2D.texture = load("res://art/Msg-You Survived.png")
	$Sprite2D.show()
	$ColorRect.show()
	$NextButton.show()
	$"/root/Level/fade_transition".show()
	$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	
func all_levels_done():
	$ScoreLabel.hide()
	show_message("Congrats!\nAll Levels Completed")
	$"/root/Level/fade_transition".show()
	$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	await $MessageTimer.timeout
	$Message.text = str("Play Again?")
	$Message.show()
	$ColorRect.show()
	$RestartButton.show()
	
func _on_start_button_pressed():
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _on_next_button_pressed():
	$"/root/Level/fade_transition".show()
	$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	get_tree().change_scene_to_file("res://level" + str(int(level) + 1) + ".tscn")

func _on_restart_button_pressed():
	$"/root/Level/fade_transition".show()
	$"/root/Level/fade_transition/AnimationPlayer".play("fade_out")
	get_tree().change_scene_to_file("res://level1.tscn")
