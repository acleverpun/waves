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
    let anchor = getNode("anchor") as Spatial

    # cardinals
    if input.isActionPressed("move_forward"):
      self.rotateY(anchor.rotation.y)
      anchor.rotation = ZERO
      translate(FORWARD * speed * dt)
    if input.isActionPressed("move_backward"):
      self.rotateY(anchor.rotation.y)
      anchor.rotation = ZERO
      translate(BACKWARD * speed * dt)
    if input.isActionPressed("move_left"):
      self.rotateY(anchor.rotation.y)
      anchor.rotation = ZERO
      translate(LEFT * speed * dt)
    if input.isActionPressed("move_right"):
      self.rotateY(anchor.rotation.y)
      anchor.rotation = ZERO
      translate(RIGHT * speed * dt)

    # turning
    if input.isActionPressed("move_turn_left"):
      if cameraGrabbed:
        self.rotateY(anchor.rotation.y)
        anchor.rotation = ZERO
        translate(LEFT * speed * dt)
      else:
        rotateY(angularSpeed * dt)
    if input.isActionPressed("move_turn_right"):
      if cameraGrabbed:
        self.rotateY(anchor.rotation.y)
        anchor.rotation = ZERO
        translate(RIGHT * speed * dt)
      else:
        rotateY(-angularSpeed * dt)
    if input.isActionJustPressed("move_turn_around"):
      rotateY(PI)
