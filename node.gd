extends Node

func _ready() -> void:
	pass
	
func _on_animated_sprite_2d_animation_finished():
	$fade_transition.show()
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	get_tree().change_scene_to_file("res://level1.tscn")
