include globals

import
  node_2d

type DrawOp* = ref object
  kind: string
  args: varargs

gdobj DebugController of Node2d:
  var things: seq[Vector2]

  method ready() =
    discard getParent().callDeferred("move_child", newVariant(self), newVariant(2))

  # method draw() =
  #   drawCircle(vec2(0, 0), 100, initColor(255, 0, 0))
