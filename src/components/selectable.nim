include globals

import
  input_event,
  input_event_mouse_button,
  node_2d,
  viewport

import
  controllers/target_controller as _

gdobj Selectable of Node2d:
  var parent: Node2d
  var targetController: TargetController

  method ready() =
    parent = getParent() as Node2d
    targetController = getNode("/root/targetController") as TargetController
    discard parent.connect("input_event", self, "on_input_event", newArray())

  proc onInputEvent(viewport: Viewport, event: InputEvent, shapeIndex: int) {.gdExport.} =
    if event of InputEventMouseButton and (event as InputEventMouseButton).pressed:
      targetController.setTarget(parent)
