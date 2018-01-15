include ../global

import
  input,
  node_2d,
  scene_tree

gdobj World of Node2d:
  method input(event: InputEvent) =
    if input.isActionJustPressed("quit"): getTree().quit()
