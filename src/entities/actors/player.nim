include globals

import math, strutils

import
  input,
  input.input_manager,
  node_2d,
  polygon_2d,
  viewport

import
  utils.math_utils

gdobj Player of Polygon2d:
  var speed* = 200.0
  var angularSpeed* = 5.0

  var targetRot*: float
  var inputManager: InputManager[Player] = newInputManager(self)

  method init() =
    discard

  method ready() =
    inputManager.ready()

  method process(dt: float64) =
    inputManager.process(dt)

  proc move*(vector: Vector2, dt: float64) =
    var movement = vector.clamped(1) * speed * dt
    self.position = self.position + movement
