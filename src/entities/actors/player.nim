include globals

import
  input,
  kinematic_body

const
  forward = vec3(0, 0, -1)
  backward = vec3(0, 0, 1)
  left = vec3(-1, 0, 0)
  right = vec3(1, 0, 0)

gdobj Player of KinematicBody:
  var speed* = 1.0

  var velocity: Vector3

  method process(dt: float) =
    if input.isActionPressed("forward"): velocity += forward
    if input.isActionPressed("backward"): velocity += backward
    if input.isActionPressed("left"): velocity += left
    if input.isActionPressed("right"): velocity += right

    velocity = moveAndSlide(velocity)
