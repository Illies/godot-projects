extends Node2D
const PLAYER = preload("res://player.tscn")
@onready var node_2d: Node2D = $Node2D
const BULLET = preload("res://bullet.tscn")
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		var bullet = BULLET.instantiate()
		get_tree().root.add_child(bullet)
		bullet.bulletDirection = (node_2d.global_position - global_position).normalized()
		bullet.position = node_2d.global_position
		bullet.look_at(get_global_mouse_position())
