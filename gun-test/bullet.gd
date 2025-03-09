extends Area2D
@export var bulletDirection: Vector2
@onready var timer: Timer = $Timer

const bulletSpeed = 5000
var playerVel: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(3)
	var player = get_tree().get_first_node_in_group("Player")
	if player and player is CharacterBody2D:
		playerVel = player.velocity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += ((bulletDirection * bulletSpeed) + playerVel) * delta
	

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()
		queue_free()
