extends Node

func reparent(scene, child, parent):
	var oldParent = child.get_parent()
	print(oldParent.name, " => ", parent.name, ": ", child.name)
	oldParent.remove_child(child)
	parent.add_child(child)
	child.set_owner(scene)

func post_import(scene):
	var main = scene.get_node("main")

	for layer in scene.get_children():
		if layer is TileMap: continue

		for child in layer.get_children():
			reparent(scene, child, main)
		layer.free()

	return scene
