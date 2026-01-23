extends RigidBody2D

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	player = get_node("/root/Level1/player")
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
#
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _physics_process(_delta: float) -> void:
	if player:
		look_at(player.global_position)
		var direction = global_position.direction_to(player.global_position)
		var speed = randf_range(50.0, 150.0)
		apply_central_force(direction * speed)
