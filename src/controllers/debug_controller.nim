include globals

import
  node_2d

gdobj DebugController of Node2d:
  # var things = @[]

  method ready() =
    discard getParent().callDeferred("move_child", newVariant(self), newVariant(2))

  method draw() =
    drawCircle(vec2(0, 0), 100, initColor(255, 0, 0))
