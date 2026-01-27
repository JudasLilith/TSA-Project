extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over():
	get_tree().call_group("mobs", "queue_free")
	$ScoreTimer.paused = true
	$MobTimer.stop()
	$hud.show_game_over()

func create_mob():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf() # Choose a random location on Path2D
	mob.global_position = mob_spawn_location.global_position # Set the mob's position to the random location
	mob.rotation = 0 # Reset rotation to 0 so it faces forward
	add_child(mob)
	
func new_game():
	$"hud/StartButton".hide()
	$fade_transition.show()
	$fade_transition/AnimationPlayer.play("fade_out")
	$"/root/Level/player".input_enabled = false
	$player.start($StartPosition.position)
	get_tree().call_group("mobs", "queue_free")
	$"hud/Sprite2D".hide()
	$"hud/ScoreLabel".hide()
	$hud.show_message("Level " + hud.level + " of " + str(hud.LEVELS))
	await $"hud/MessageTimer".timeout
	$hud.show_message("Get Ready")
	await $"hud/MessageTimer".timeout
	$"hud/ColorRect".hide()
	$"/root/Level/player".input_enabled = true
	$"hud/ScoreLabel".show()
	$ScoreTimer.start()
	$ScoreTimer.paused = false
	create_mob()
	$MobTimer.start()

func _on_mob_timer_timeout():
	create_mob()
	
func _on_score_timer_timeout():
	get_tree().call_group("mobs", "queue_free")
	$MobTimer.stop()
	$"/root/Level/player".input_enabled = false
	if int($hud.level) < $hud.LEVELS:
		$hud.show_game_end()
	else:
		$hud.all_levels_done()
