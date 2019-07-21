extends Node

onready var host = get_parent().get_parent()
onready var body = host.get_node("body")

func _ready():
	body.input_pickable = true
	events.emit_signal("selectable:created", host)
