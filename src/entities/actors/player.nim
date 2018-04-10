include globals

import
  input,
  kinematic_body,
  math

gdobj Player of KinematicBody:
  var speed* = 10.0
  var angularSpeed* = PI
  var autorun = false

  method process(dt: float) =
    let cameraGrabbed = input.isMouseButtonPressed(2)
    let anchor = getNode("anchor") as Spatial

    var move: Vector3

    if input.isActionJustPressed("move_autorun"): autorun = not autorun

    # cardinals
    if input.isActionPressed("move_forward"):
      move += FORWARD
      autorun = false
    if input.isActionPressed("move_backward"):
      move += BACKWARD
      autorun = false
    if input.isActionPressed("move_left") or cameraGrabbed and input.isActionPressed("move_turn_left"):
      move += LEFT
    if input.isActionPressed("move_right") or cameraGrabbed and input.isActionPressed("move_turn_right"):
      move += RIGHT

    # autorun
    if autorun: move += FORWARD

    # turning
    if not cameraGrabbed:
      if input.isActionPressed("move_turn_left"): rotateY(angularSpeed * dt)
      if input.isActionPressed("move_turn_right"): rotateY(-angularSpeed * dt)
    if input.isActionJustPressed("move_turn_around"): rotateY(PI)

    if move != ZERO:
      rotateY(anchor.rotation.y)
      anchor.rotation = ZERO
      translate(move.normalized * speed * dt)
