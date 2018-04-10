include globals

import
  camera,
  input,
  input_event_mouse_motion,
  math

gdobj PlayerCam of Camera:
  var mouseSensitivity* = 0.2

  method input(event: InputEvent) =
    if event of InputEventMouseMotion and input.isMouseButtonPressed(2):
      let motionEvent = event as InputEventMouseMotion
      let anchor = getParentSpatial()
      anchor.rotateY(PI / 180 * -motionEvent.relative.x * mouseSensitivity)

  method process(dt: float) =
    discard    
