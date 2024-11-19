extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var ray_cast_2d = $RayCast2D
@onready var collision_shape_2d = $CollisionShape2D

@export var SPEED = 200.0  # Export speed for easy tweaking in the editor
var dead = false
var player: Node2D = null  # Store the player as a Node2D reference

# Called when the node is added to the scene
func _ready():
	animated_sprite_2d.animation = "default"
	add_to_group("zombies")

# Physics process to handle movement
func _physics_process(delta: float) -> void:
	if player == null:
		return  # Return if the player is not assigned
	if dead:
		return
	# Calculate the direction to the player
	var direction = (player.position - position).normalized()
	
	# Make the zombie look at the player
	look_at(player.position)
	
	# Move the zombie towards the player
	move_and_collide(direction * SPEED * delta)
	
	# Check if the RayCast2D is colliding with the player
	if ray_cast_2d.is_colliding():
		var coll = ray_cast_2d.get_collider()
		if coll.name == "player":
			coll.kill()

# Called when the zombie is killed
func kill():
	#queue_free()
	dead = true
	collision_shape_2d.disabled = true
	animated_sprite_2d.animation = "new_animation"
# Set the player target
func set_player(p):
	player = p
