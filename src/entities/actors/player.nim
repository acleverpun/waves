include globals

import
  input,
  kinematic_body,
  math

gdobj Player of KinematicBody:
  var speed* = 10.0
  var angularSpeed* = PI

  method process(dt: float) =
    let cameraGrabbed = input.isMouseButtonPressed(2)

    # cardinals
    if input.isActionPressed("move_forward"):
      translate(FORWARD * speed * dt)
    if input.isActionPressed("move_backward"):
      translate(BACKWARD * speed * dt)
    if input.isActionPressed("move_left"):
      if cameraGrabbed:
        translate(LEFT * speed * dt)
      else:
        rotateY(angularSpeed * dt)
    if input.isActionPressed("move_right"):
      if cameraGrabbed:
        translate(RIGHT * speed * dt)
      else:
        rotateY(-angularSpeed * dt)

    # strafing
    if input.isActionPressed("move_strafe_left"):
      translate(LEFT * speed * dt)
    if input.isActionPressed("move_strafe_right"):
      translate(RIGHT * speed * dt)
