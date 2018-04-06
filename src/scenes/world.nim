include globals

import
  input,
  scene_tree,
  spatial

gdobj World of Spatial:
  method input(event: InputEvent) =
    if input.isActionJustPressed("quit"): getTree().quit()
    elif input.isActionJustPressed("restart"): discard getTree().reloadCurrentScene()
