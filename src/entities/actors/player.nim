include ../../polyfill

import
  input,
  node_2d,
  polygon_2d

const
  LEFT = vec2(-1, 0)
  RIGHT = vec2(1, 0)
  UP = vec2(0, -1)
  DOWN = vec2(0, 1)

gdobj Player of Polygon2d:
  var speed: float = 2

  method physicsProcess(dt: float64) =
    if input.isActionPressed("left"): move(LEFT)
    elif input.isActionPressed("right"): move(RIGHT)
    if input.isActionPressed("up"): move(UP)
    elif input.isActionPressed("down"): move(DOWN)

  method move(vector: Vector2) {.base.} =
    self.position = self.position + vector * speed
