extends CharacterBody2D

const MOVE_SPEED = 300
var mag_size = 6
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@onready var label = $"../CanvasLayer/Label"

@onready var point_light_2d = $PointLight2D

@onready var ray_cast_2d = $RayCast2D

@onready var flash_light = $flash_light
@onready var background = $Background

func _ready():
	point_light_2d.visible = false
	background.visible = false
	await get_tree().process_frame
	get_tree().call_group("zombies", "set_player", self)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	label.text = str(mag_size) + "/6"
	# Check for player input
	if Input.is_action_just_pressed("reload"):
		mag_size = 6
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_just_pressed("flash_light"):
		if flash_light.visible:
			flash_light.visible = false
		else:
			flash_light.visible = true
	# Normalize input vector to avoid faster diagonal movement
	input_vector = input_vector.normalized()

	# Apply movement
	velocity = input_vector * MOVE_SPEED
	look_at(get_global_mouse_position())
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and mag_size > 0:
		mag_size -= 1
		point_light_2d.visible = true 
		audio_stream_player_2d.play()
		var coll = ray_cast_2d.get_collider()
		if ray_cast_2d.is_colliding() and coll.has_method("kill"):
			coll.kill()
		await get_tree().create_timer(0.5).timeout
	point_light_2d.visible = false
func kill():
	get_tree().reload_current_scene()
