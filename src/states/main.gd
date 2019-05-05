extends Node

onready var Zone = preload("res://src/zones/courtyard.tscn")

func _ready():
	var zone = Zone.instance()

	add_child(zone)
