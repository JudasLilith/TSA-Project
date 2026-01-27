
extends CharacterBody2D
signal hit

@export var speed = 100 # How fast the player will move (pixels/sec)
var screen_size # Size of the game window
var input_enabled = true

func _ready():
	screen_size = get_viewport_rect().size

func  _physics_process(_delta):
	if input_enabled:
		if Input.is_action_pressed("move_right"):
			velocity = Vector2.RIGHT #velocity.x += 1
		elif Input.is_action_pressed("move_left"):
			velocity = Vector2.LEFT #velocity.x -= 1
		elif Input.is_action_pressed("move_down"):
			velocity = Vector2.DOWN #velocity.y += 1
		elif Input.is_action_pressed("move_up"):
			velocity = Vector2.UP #velocity.y -= 1
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _process(delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
func start(pos):
	position = pos
	velocity = Vector2.ZERO
	show()
	$WallDetector.disabled = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("mobs"):
		$"/root/Level/player".input_enabled = false
		hide() # Player disappears after getting infected
		hit.emit()
		$WallDetector.set_deferred("disabled", true) # Must be deferred as we can't change physics properties on a physics callback
		$"/root/Level".game_over()
