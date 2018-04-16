include globals

import
  input,
  kinematic_body_2d,
  math,
  spatial,
  sprite,
  viewport

gdobj Player of KinematicBody2d:
  var speed* = 10000.0
  var runModifier* = 4.0
  var viewport: Viewport
  var sprite: Sprite
  var model: Spatial

  method ready() =
    viewport = getNode("viewport") as Viewport
    sprite = getNode("sprite") as Sprite
    model = viewport.getNode("model") as Spatial

    sprite.texture = viewport.getTexture()

  method physicsProcess(dt: float) =
    var move: Vector2
    var currentSpeed = speed

    # cardinals
    if input.isActionPressed("move_up"):
      move += UP
    if input.isActionPressed("move_down"):
      move += DOWN
    if input.isActionPressed("move_left"):
      move += LEFT
    if input.isActionPressed("move_right"):
      move += RIGHT

    if input.isActionPressed("move_run"):
      currentSpeed *= runModifier

    if move != ZERO:
      model.rotation = vec3(0, move.angle - PI/2, 0)
      discard moveAndSlide(move.normalized * currentSpeed * dt)
