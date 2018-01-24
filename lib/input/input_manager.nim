import
  godot,
  input,
  polygon_2d

import
  utils.math_utils

type
  Controller {.pure.} = enum gamepad, keyboard
  Deadzone* = tuple[ position: float, rotation: float ]
  InputManager*[T] = ref object
    player: T
    controller: Controller
    deadzone: Deadzone

const
  LEFT = vec2(-1, 0)
  RIGHT = vec2(1, 0)
  UP = vec2(0, -1)
  DOWN = vec2(0, 1)

proc newInputManager*[T](player: T, deadzone: Deadzone = ( 0.3, 0.5 )): InputManager[T] =
  new(result)
  result.player = player
  result.deadzone = deadzone

method ready*(self: InputManager) {.base, gcsafe, locks:0.} =
  if input.getConnectedJoypads().len > 0:
    self.controller = Controller.gamepad
  else:
    self.controller = Controller.keyboard

  case self.controller:
    of Controller.gamepad:
      discard
    of Controller.keyboard:
      input.setMouseMode(MOUSE_MODE_CAPTURED)

method process*(self: InputManager, dt: float64) {.base, gcsafe, locks:0.} =
  var movement, rotation: Vector2

  case self.controller:
    of Controller.gamepad:
      if input.isJoyKnown(0):
        movement = vec2(input.getJoyAxis(0, 0), input.getJoyAxis(0, 1))
        rotation = vec2(input.getJoyAxis(0, 2), input.getJoyAxis(0, 3))
    of Controller.keyboard:
      if movement.length < self.deadzone[0]:
        if input.isActionPressed("left"): movement += LEFT
        elif input.isActionPressed("right"): movement += RIGHT
        if input.isActionPressed("up"): movement += UP
        elif input.isActionPressed("down"): movement += DOWN

      # TODO: better mouse rotation
      if rotation.length < self.deadzone[1]:
        rotation = self.player.getViewport().getMousePosition() - self.player.position

  if movement.length >= self.deadzone[0]: self.player.move(movement, dt)

  # TODO: use a real lerp
  if rotation.length >= self.deadzone[1]:
    self.player.targetRot = rotation.angle
  if self.player.targetRot != self.player.rotation:
    if abs(self.player.targetRot - self.player.rotation) <= 0.1: self.player.rotation = self.player.targetRot
    else: self.player.rotation = lerpAngle(self.player.rotation, self.player.targetRot, self.player.angularSpeed * dt)
