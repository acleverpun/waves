extends KinematicBody2D

onready var viewport = get_node("viewport")
onready var sprite = get_node("sprite")

func _ready():
	sprite.texture = viewport.get_texture()
