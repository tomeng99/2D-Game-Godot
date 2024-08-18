extends CharacterBody2D

@onready var camera = $Camera2D
var is_local_player = false
var last_direction = Vector2.ZERO

func _ready():
	if is_multiplayer_authority():
		is_local_player = true
		camera.make_current()

func _enter_tree():
	set_multiplayer_authority(name.to_int())
 
func _physics_process(_delta):
	if is_multiplayer_authority():
		var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_vector * 100
			

		# Determine the direction of movement and play the corresponding animation
		if input_vector.x < 0:
			$Sprite2D.play("walk_left")
			last_direction = Vector2.LEFT
		elif input_vector.x > 0:
			$Sprite2D.play("walk_right")
			last_direction = Vector2.RIGHT
		elif input_vector.y < 0:
			$Sprite2D.play("walk_up")
			last_direction = Vector2.UP
		elif input_vector.y > 0:
			$Sprite2D.play("walk_down")
			last_direction = Vector2.DOWN
		else:
			# No movement input, play the idle animation based on the last direction
			if last_direction == Vector2.LEFT:
				$Sprite2D.play("idle_left")
			elif last_direction == Vector2.RIGHT:
				$Sprite2D.play("idle_right")
			elif last_direction == Vector2.UP:
				$Sprite2D.play("idle_up")
			elif last_direction == Vector2.DOWN:
				$Sprite2D.play("idle_down")

		# Play attack animation if the attack action is pressed
		if Input.is_action_pressed("Attack"):
			$Weapon/AnimationPlayer.play("Hit")

		# Apply movement
		move_and_slide()
 
