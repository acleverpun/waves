extends Node

onready var Zone = preload("res://src/zones/courtyard.tscn")

func _ready():
	var zone = Zone.instance()

	add_child(zone)

func _input(event):
	if Input.is_action_pressed("game.close"): get_tree().quit()
