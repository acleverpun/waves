extends Node

onready var selected: Node setget select

func _ready():
	events.needs([
		"selectable:created",
		"selector:deselect",
		"selector:select",
	])

	events.on("selectable:created", self, "selectableCreated")

func _input(event):
	if Input.is_action_pressed("target.clear"): deselect()

func selectableCreated(entity: Node):
	var body = entity.get_node("body")
	body.connect("input_event", self, "onInputEvent", [ entity ])

func onInputEvent(viewport, event, shapeIndex, entity):
	if not event is InputEventMouseButton: return
	if not event.pressed: return

	if event.button_index == 1:
		select(entity)

func select(entity: Node):
	if selected != entity:
		selected = entity
		prints("Selected", selected.name, selected)
		events.emit_signal("selector:select", selected)

func deselect():
	if selected:
		prints("Deselected", selected.name, selected)
		selected = null
		events.emit_signal("selector:deselect", selected)
