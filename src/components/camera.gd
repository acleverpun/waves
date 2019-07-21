extends Node

const zoomMax = Vector2(1.0, 1.0)
const zoomMin = Vector2(0.1, 0.1)
const zoomStep = Vector2(0.1, 0.1)

onready var host = get_parent().get_parent()
onready var cam = host.find_node("cam")

func _ready():
	zoom()

func _input(event):
	if Input.is_action_pressed("cam.zoom-in") and cam.zoom - zoomStep > zoomMin:
		zoom(-1)
	elif Input.is_action_pressed("cam.zoom-out") and cam.zoom < zoomMax:
		zoom(1)

func zoom(level: int = 0):
	cam.zoom += level * zoomStep

	# TODO: vet need
	# var dragMargin = 0.5 * cam.zoom.x
	# cam.drag_margin_top = dragMargin
	# cam.drag_margin_bottom = dragMargin
	# cam.drag_margin_left = dragMargin
	# cam.drag_margin_right = dragMargin
