extends Node

var Selectable = load("res://src/components/selectable.tscn")

func setOwner(scene, node):
	node.set_owner(scene)
	for child in node.get_children():
		setOwner(scene, child)

func reparent(scene, node, parent):
	var oldParent = node.get_parent()
	print(oldParent.name, " => ", parent.name, ": ", node.name)
	oldParent.remove_child(node)
	parent.add_child(node)
	setOwner(scene, node)

func post_import(scene):
	var main = scene.get_node("main")

	for layer in scene.get_children():
		if layer is TileMap: continue

		for child in layer.get_children():
			reparent(scene, child, main)
			if child.has_meta("selectable"):
				child.input_pickable = true
				var selectable = Selectable.instance()
				child.add_child(selectable)
				setOwner(scene, selectable)
		layer.free()

	return scene
