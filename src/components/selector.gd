extends Node

onready var selected: Node

func _ready():
	events.on("selectable:created", self, "selectableCreated")

func selectableCreated(entity: Node):
	var body = entity.get_node("body")
	body.connect("input_event", self, "onInputEvent", [ entity ])

func onInputEvent(viewport, event, shapeIndex, entity):
	if not event is InputEventMouseButton: return
	if not event.pressed: return

	if event.button_index == 1:
		select(entity)

func select(entity: Node):
	selected = entity
	prints("Selected", entity.name, entity)

func deselect():
	if selected:
		prints("Deselected", selected.name, selected)
		selected = null
