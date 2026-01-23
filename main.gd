extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$hud.show_game_over()

func new_game():
	$fade_transition.show()
	$fade_transition/AnimationPlayer.play("fade_out")
	
	$player.start($StartPosition.position)
	get_tree().call_group("mobs", "queue_free")
	$MobTimer.start() # Since mob timer is same length as message timer
	$hud.show_message("Get Ready")
	await $"hud/MessageTimer".timeout
	$"hud/ScoreLabel".show()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location, but reset rotation to 0 so it faces forward.
	mob.global_position = mob_spawn_location.global_position
	mob.rotation = 0 

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
