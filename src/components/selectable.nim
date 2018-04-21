include globals

import
  input_event,
  input_event_mouse_button,
  node,
  viewport

gdobj Selectable of Node:
  method ready() =
    discard getParent().connect("input_event", self, "on_input_event", newArray())

  proc onInputEvent(viewport: Viewport, event: InputEvent, shapeIndex: int) {.gdExport.} =
    if event of InputEventMouseButton and (event as InputEventMouseButton).pressed:
      print "select"
