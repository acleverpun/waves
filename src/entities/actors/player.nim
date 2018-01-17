import math, strutils

include ../../global

import
  ../../utils/math_utils,
  input,
  node_2d,
  polygon_2d,
  viewport

const
  LEFT = vec2(-1, 0)
  RIGHT = vec2(1, 0)
  UP = vec2(0, -1)
  DOWN = vec2(0, 1)

gdobj Player of Polygon2d:
  var speed* = 200.0
  var angularSpeed* = 5.0
  var deadzone* = [ 0.3, 0.5 ]

  var targetRot: float

  method ready() =
    discard

  method process(dt: float64) =
    var movement, rotation: Vector2

    # controller

    if input.isJoyKnown(0):
      movement = vec2(input.getJoyAxis(0, 0), input.getJoyAxis(0, 1))
      rotation = vec2(input.getJoyAxis(0, 2), input.getJoyAxis(0, 3))

    # keyboard

    if movement.length < deadzone[0]:
      if input.isActionPressed("left"): movement += LEFT
      elif input.isActionPressed("right"): movement += RIGHT
      if input.isActionPressed("up"): movement += UP
      elif input.isActionPressed("down"): movement += DOWN

    if rotation.length < deadzone[1]:
      rotation = getViewport().getMousePosition() - self.position

    if movement.length >= deadzone[0]: move(movement, dt)

    # TODO: use a real lerp
    # TODO: fix crossing the +-0 angle
    if rotation.length >= deadzone[1]:
      targetRot = rotation.angle
    if targetRot != self.rotation:
      if abs(targetRot - self.rotation) <= 0.1: self.rotation = targetRot
      else: self.rotation = lerp(self.rotation, targetRot, angularSpeed * dt)

  method move(vector: Vector2, dt: float64) {.base.} =
    var movement = vector.clamped(1) * speed * dt
    self.position = self.position + movement
