include globals

import
  input,
  kinematic_body_2d

gdobj Player of KinematicBody2d:
  var speed* = 10000.0
  var runModifier* = 4.0

  method physicsProcess(dt: float) =
    var move: Vector2
    var currentSpeed = speed

    # cardinals
    if input.isActionPressed("move_up"):
      move += UP
    if input.isActionPressed("move_down"):
      move += DOWN
    if input.isActionPressed("move_left"):
      move += LEFT
    if input.isActionPressed("move_right"):
      move += RIGHT

    if input.isActionPressed("move_run"):
      currentSpeed *= runModifier

    if move != ZERO:
      self.rotation = move.angle
      discard moveAndSlide(move.normalized * currentSpeed * dt)
