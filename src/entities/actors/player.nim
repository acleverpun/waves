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

  var anim: string
  var animTween = 0.2
  var animSpeed = 1.0

  var viewport: Viewport
  var sprite: Sprite
  var model: Spatial
  var animPlayer: AnimationPlayer
  var pivot: Node2d

  method ready() =
    viewport = getNode("viewport") as Viewport
    sprite = getNode("sprite") as Sprite
    model = viewport.getNode("model") as Spatial
    animPlayer = model.getNode("animationPlayer") as AnimationPlayer
    pivot = getNode("pivot") as Node2d

    sprite.texture = viewport.getTexture()

    animPlayer.getAnimation("Idle").loop = true
    animPlayer.getAnimation("Walk").loop = true

  method physicsProcess(dt: float) =
    var move: Vector2
    var currentSpeed = speed
    var currentAnim = anim
    var currentAnimSpeed = animSpeed

    # cardinals
    if input.isActionPressed("move_up"):
      move += UP
    if input.isActionPressed("move_down"):
      move += DOWN
    if input.isActionPressed("move_left"):
      move += LEFT
    if input.isActionPressed("move_right"):
      move += RIGHT

    if move == ZERO:
      currentAnim = "Idle"
    else:
      if input.isActionPressed("move_run"):
        currentSpeed *= runModifier
        currentAnimSpeed *= runModifier

      currentAnim = "Walk"
      pivot.rotation = move.angle
      model.rotation = vec3(0, move.angle - PI/2, 0)
      discard moveAndSlide(move.normalized * currentSpeed * dt)

    if currentAnim != anim or input.isActionJustPressed("move_run") or input.isActionJustReleased("move_run"):
      anim = currentAnim
      animPlayer.play(currentAnim, animTween, currentAnimSpeed)
