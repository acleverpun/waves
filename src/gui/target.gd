extends Label

func _ready():
	events.needs([
		"selection:deselect",
		"selection:select",
	])

	events.on("selection:select", self, "onSelect")
	events.on("selection:deselect", self, "onDeselect")

func onSelect(entity: Node):
	text = entity.name

func onDeselect(entity: Node):
	text = ""
