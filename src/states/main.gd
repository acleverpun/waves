extends Node

onready var Zone = preload("res://src/zones/courtyard.tscn")

func _ready():
	add_child(Zone.instance())

func _input(event):
	if Input.is_action_pressed("game.close"): get_tree().quit()
	if Input.is_action_pressed("game.restart"): get_tree().reload_current_scene()
