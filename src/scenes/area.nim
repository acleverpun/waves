include globals

import
  input,
  node_2d,
  scene_tree

gdobj Area of Node2d:
  method ready() =
    discard

  method input(event: InputEvent) =
    if input.isActionJustPressed("quit"): getTree().quit()
    elif input.isActionJustPressed("restart"): discard getTree().reloadCurrentScene()
