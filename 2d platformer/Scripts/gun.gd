extends Node2D

const BULLET = preload("res://Scenes/bullet.tscn")
@onready var marker_2d = $Marker2D
@onready var point_light_2d = $PointLight2D
@onready var muzzle_flash = $MuzzleFlash
@onready var timer = $Timer
@onready var gun_shot_sound = $gunShot
@onready var bullet_sound = $bulletSound
@onready var reload_sound = $reloadSound

@export var mag_size = 4
@export var round_amount = 25

func _ready():
	point_light_2d.visible = false
	muzzle_flash.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("fire") and round_amount > 0:
		round_amount -= 1
		point_light_2d.visible = true
		muzzle_flash.visible = true
		gun_shot_sound.play()
		timer.start(0.05)
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = marker_2d.global_position
		bullet_instance.rotation = rotation
		play_bullet_drop_sfx()
	if Input.is_action_just_pressed("reload") and mag_size > 0:
		reload_sound.play()
		mag_size -= 1
		round_amount = 25
		await get_tree().create_timer(0.7).timeout
	look_at(get_global_mouse_position())

func _on_timer_timeout():
	point_light_2d.visible = false
	muzzle_flash.visible = false
	
func play_bullet_drop_sfx():
	await get_tree().create_timer(0.5).timeout
	bullet_sound.play()
