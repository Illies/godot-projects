extends CharacterBody2D

@onready var gun: Node2D = $Gun
@export var plyrVelocity: Vector2
const SPEED = 1000.0
const JUMP_VELOCITY = -800.0


func _physics_process(delta: float) -> void:
	plyrVelocity = velocity
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	gun.look_at(get_global_mouse_position())
	move_and_slide()
