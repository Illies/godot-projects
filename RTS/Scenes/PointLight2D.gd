extends PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("LeftClick"):
		print(1)
		visible = false
	if Input.is_action_just_released("LeftClick"):
		visible = true