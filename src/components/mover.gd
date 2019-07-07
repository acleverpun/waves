extends Node

const ZERO = Vector2(0, 0)
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

export var speed = 50.0

onready var parent = get_parent()

var velocity := ZERO

func _physics_process(dt):
	movement(dt)

func movement(dt):
	velocity = ZERO

	if Input.is_action_pressed('move.up'):
		velocity += UP
	if Input.is_action_pressed('move.down'):
		velocity += DOWN
	if Input.is_action_pressed('move.left'):
		velocity += LEFT
	if Input.is_action_pressed('move.right'):
		velocity += RIGHT

	velocity = velocity.clamped(1)

	parent.move_and_slide(velocity * speed)
