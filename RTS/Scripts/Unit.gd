extends CharacterBody2D

@export var selected = false
@onready var label = get_node("Label")

@onready var target = position
var follow_cursor = false
var Speed = 50

func _ready():
	_set_selected(selected)
	
func _set_selected(value):
	label.visible = value
