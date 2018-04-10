include globals

import
  input,
  input_event,
  input_event_mouse_motion,
  kinematic_body,
  math

const
  left = vec3(-1, 0, 0)
  right = vec3(1, 0, 0)
  forward = vec3(0, 0, -1)
  backward = vec3(0, 0, 1)
  up = vec3(0, 1, 0)
  down = vec3(0, -1, 0)

gdobj Player of KinematicBody:
  var speed* = 10.0
  var angularSpeed* = PI
  var mouseSensitivity* = 0.2

  method input(event: InputEvent) =
    if event of InputEventMouseMotion and input.isMouseButtonPressed(2):
      let motionEvent = event as InputEventMouseMotion
      let tether = getNode("cameraTether") as Spatial
      tether.rotateY(PI / 180 * -motionEvent.relative.x * mouseSensitivity)

  method process(dt: float) =
    let cameraGrabbed = input.isMouseButtonPressed(2)

    # cardinals
    if input.isActionPressed("move_forward"):
      translate(forward * speed * dt)
    if input.isActionPressed("move_backward"):
      translateObjectLocal(backward * speed * dt)
    if input.isActionPressed("move_left"):
      if cameraGrabbed:
        translateObjectLocal(left * speed * dt)
      else:
        rotateY(angularSpeed * dt)
    if input.isActionPressed("move_right"):
      if cameraGrabbed:
        translateObjectLocal(right * speed * dt)
      else:
        rotateY(-angularSpeed * dt)
    # strafing
    if input.isActionPressed("move_strafe_left"):
      translateObjectLocal(left * speed * dt)
    if input.isActionPressed("move_strafe_right"):
      translateObjectLocal(right * speed * dt)
