extends Label

func _ready():
	events.needs([
		"selector:deselect",
		"selector:select",
	])

	events.on("selector:select", self, "onSelect")
	events.on("selector:deselect", self, "onDeselect")

func onSelect(entity: Node):
	text = entity.name

func onDeselect(entity: Node):
	text = null
