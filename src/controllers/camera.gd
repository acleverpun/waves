extends Node

const zoomMax = Vector2(1.0, 1.0)
const zoomMin = Vector2(0.1, 0.1)
const zoomStep = Vector2(0.1, 0.1)

func _ready():
	zoom()

func _input(event):
	if Input.is_action_pressed("cam.zoom-in") and self.zoom - zoomStep > zoomMin:
		zoom(-1)
	elif Input.is_action_pressed("cam.zoom-out") and self.zoom < zoomMax:
		zoom(1)

func zoom(level: int = 0):
	self.zoom += level * zoomStep

	# TODO: vet need
	# var dragMargin = 0.5 * self.zoom.x
	# self.drag_margin_top = dragMargin
	# self.drag_margin_bottom = dragMargin
	# self.drag_margin_left = dragMargin
	# self.drag_margin_right = dragMargin
