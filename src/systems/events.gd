extends Node

func _ready():
	prints("Event system ready")

func create(event: String):
	add_user_signal(event)

func createAll(events: Array):
	for event in events:
		create(event)

func on(event: String, node: Node, method: String, args: Array = []):
	prints("Binding event...", event, method)
	connect(event, node, method)
