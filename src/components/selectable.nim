include globals

import
  input_event,
  input_event_mouse_button,
  node,
  viewport

import
  controllers/target_controller as _

gdobj Selectable of Node:
  var parent: Node
  var targetController: TargetController

  method ready() =
    parent = getParent()
    targetController = getNode("/root/targetController") as TargetController
    discard parent.connect("input_event", self, "on_input_event", newArray())

  proc onInputEvent(viewport: Viewport, event: InputEvent, shapeIndex: int) {.gdExport.} =
    if event of InputEventMouseButton and (event as InputEventMouseButton).pressed:
      targetController.setTarget(parent)
