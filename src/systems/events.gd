extends Node

func _ready():
	prints("Event system ready")

func on(event: String, node: Node, method: String, args: Array = []):
	prints("Binding event...", event, method)
	add_user_signal(event, args)
	connect(event, node, method)
