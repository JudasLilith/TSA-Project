extends Node2D

var button_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_start_button_pressed() -> void:
	button_type = "start"
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	#get_tree().chan	$fade_transition/AnimationPlayer.play("fade_out")ge_scene_to_file("res://main.tscn")

func _on_about_us_button_pressed() -> void:
	button_type = "about_us"
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://cutscene.tscn")
	elif button_type == "about_us":
		get_tree().change_scene_to_file("res://player2.tscn") ##some arbitrary shit, fix it right fucking now
