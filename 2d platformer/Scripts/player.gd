extends CharacterBody2D
@onready var player = $"."
@onready var pixel_m_4 = $Gun
@onready var bones = $Bones
@onready var head = $Body/Head
@onready var gun = $Gun
@onready var label = $CanvasLayer/Label

var SPEED = 300.0
const JUMP_VELOCITY = -300.0
var isLoookingRight = false
var isGunLookRight = true
var isLeaning = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $AnimationPlayer
@onready var foot_step_audio = $footStepAudio

func _ready():
	animation_player.play("idle")

func _physics_process(delta):
	if get_global_mouse_position().x > global_position.x:
		isLoookingRight = true
	else:
		isLoookingRight = false
	
	print(isLoookingRight)
	label.text = str(gun.round_amount) + "/" + str(gun.mag_size)
	if not is_on_floor():
		velocity.y += gravity * delta
	head.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < position.x and isGunLookRight:
		isGunLookRight = false
	if get_global_mouse_position().x > position.x and !isGunLookRight:
		isGunLookRight = true
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if !is_on_floor():
			animation_player.stop()
	if isLeaning:
		SPEED = 175
	else:
		SPEED = 250
	if direction:
		if isLeaning:
			animation_player.play("lean_walk")
		else:
			animation_player.play("walk")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if isLeaning:
			animation_player.play("lean_idle")
		else:
			animation_player.play("idle")
	if Input.is_action_just_pressed("lean") and isLeaning:
		animation_player.play("idle")
		isLeaning = false
		print("leaning = true")
	elif Input.is_action_just_pressed("lean") and !isLeaning:
		animation_player.play("lean_idle")
		print("leaning = false")
		isLeaning = true
	move_and_slide()

func _foot_step_audio():
	foot_step_audio.play()
