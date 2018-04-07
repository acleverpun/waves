include globals

import
  input,
  scene_tree,
  spatial

gdobj World of Spatial:
  method ready() =
    # input.setMouseMode(input.MOUSE_MODE_CONFINED)
    discard

  method input(event: InputEvent) =
    if input.isActionJustPressed("quit"):
      input.setMouseMode(input.MOUSE_MODE_VISIBLE)
      getTree().quit()
    elif input.isActionJustPressed("restart"): discard getTree().reloadCurrentScene()
