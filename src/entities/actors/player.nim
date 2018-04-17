include globals

import
  animation,
  animation_player,
  input,
  kinematic_body_2d,
  math,
  spatial,
  sprite,
  viewport

gdobj Player of KinematicBody2d:
  var speed* = 10000.0
  var runModifier* = 4.0

  var animation: string
  var tween = 0.2

  var viewport: Viewport
  var sprite: Sprite
  var model: Spatial
  var animPlayer: AnimationPlayer

  method ready() =
    viewport = getNode("viewport") as Viewport
    sprite = getNode("sprite") as Sprite
    model = viewport.getNode("model") as Spatial
    animPlayer = model.getNode("animationPlayer") as AnimationPlayer

    sprite.texture = viewport.getTexture()

    animPlayer.getAnimation("Idle").loop = true
    animPlayer.getAnimation("Walk").loop = true

  method physicsProcess(dt: float) =
    var move: Vector2
    var currentSpeed = speed
    var currentAnimation = animation

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

    if move == ZERO:
      currentAnimation = "Idle"
    else:
      currentAnimation = "Walk"
      model.rotation = vec3(0, move.angle - PI/2, 0)
      discard moveAndSlide(move.normalized * currentSpeed * dt)

    if currentAnimation != animation:
      animation = currentAnimation
      animPlayer.play(currentAnimation, tween)
