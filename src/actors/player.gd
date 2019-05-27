extends KinematicBody2D

onready var viewport = get_node("viewport")
onready var sprite = get_node("sprite")
onready var model = viewport.get_node("model")
onready var animPlayer = model.get_node("animationPlayer")

func _ready():
	sprite.texture = viewport.get_texture()

	animPlayer.get_animation("Idle").loop = true
	animPlayer.get_animation("Walk").loop = true
	animPlayer.play("Idle")
