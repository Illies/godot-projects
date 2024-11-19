extends CharacterBody2D
@onready var planets_2 = $"../Planets2"
@onready var gpu_particles_2d = $GPUParticles2D
@onready var planets = $"../Planets"

var planet_array = [planets, planets_2]
const gravity_acceleration = 1000000
const rotation_speed = 1
var throttle_speed = 10
var rotation_direction = 0
var rocket_acceleration = 1
func _physics_process(delta):
	if gpu_particles_2d.material != null:
		gpu_particles_2d.process_material.velocity.direction = -velocity
	var direction = planets.position - position
	velocity += (direction.normalized() * gravity_acceleration * delta) / position.distance_to(planets.position)
	direction = planets_2.position - position
	velocity += (direction.normalized() * gravity_acceleration * delta) / position.distance_to(planets_2.position)

	rotation_direction = Input.get_axis("left", "right")
	
	rotation += rotation_direction * rotation_speed * delta
	velocity += transform.y * Input.get_axis("thruster_forward", "thruster_backward") * (rocket_acceleration * throttle_speed)
	move_and_slide()
