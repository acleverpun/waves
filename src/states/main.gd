extends Node

onready var Zone = preload("res://src/zones/courtyard.tscn")
onready var zones = $"zones"

func _ready():
	var zone = Zone.instance()
	zones.add_child(zone)

func _input(event):
	if Input.is_action_pressed("game.close"): get_tree().quit()
	if Input.is_action_pressed("game.restart"): get_tree().reload_current_scene()
