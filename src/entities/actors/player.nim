import strutils

include ../../global

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
  var speed: float = 200
  var deadzone: float = 0.2

  method ready() =
    discard

  method process(dt: float64) =
    var movement: Vector2

    # controller
    if input.isJoyKnown(0):
      movement = vec2(input.getJoyAxis(0, 0), input.getJoyAxis(0, 1))

    # keyboard
    if movement.length < deadzone:
      if input.isActionPressed("left"): movement += LEFT
      elif input.isActionPressed("right"): movement += RIGHT
      if input.isActionPressed("up"): movement += UP
      elif input.isActionPressed("down"): movement += DOWN

    if movement.length >= deadzone: move(movement, dt)

  method move(vector: Vector2, dt: float64) {.base.} =
    var movement = vector.clamped(1) * speed * dt
    self.position = self.position + movement
