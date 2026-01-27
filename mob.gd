extends RigidBody2D

var player: CharacterBody2D
var speed

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	player = get_node("/root/Level/player")
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _physics_process(_delta: float) -> void:
	if player:
		look_at(player.global_position)
		var direction = global_position.direction_to(player.global_position)
		speed = randf_range(25.0 + (25.0 * int($"/root/Level/hud".level)), 50.0 + (25.0 * int($"/root/Level/hud".level))) # Change mob speed range depending on level
		apply_central_force(direction * speed)
