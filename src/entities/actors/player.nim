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
  var speed* = 8.0
  var angularSpeed* = PI / 2
  var mouseSensitivity* = 0.05

  method input(event: InputEvent) =
    if event of InputEventMouseMotion and input.isMouseButtonPressed(2):
      let motionEvent = event as InputEventMouseMotion
      let camera = getNode("camera") as Spatial
      # camera.rotateY(PI / 180 * -motionEvent.relative.x * mouseSensitivity)
      # camera.lookAt(self as Spatial)

  method process(dt: float) =
    let cameraGrabbed = input.isMouseButtonPressed(2)

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
    if input.isActionPressed("move_forward"):
      translateObjectLocal(forward * speed * dt)
    if input.isActionPressed("move_backward"):
      translateObjectLocal(backward * speed * dt)
