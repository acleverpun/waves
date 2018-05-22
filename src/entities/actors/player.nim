include globals

import
  animation,
  animation_player,
  camera_2d,
  input,
  kinematic_body_2d,
  kinematic_collision_2d,
  math,
  spatial,
  sprite,
  viewport

const zoomMax = 1
const zoomMin = 0.2
const zoomStep = vec2(0.1, 0.1)

gdobj Player of KinematicBody2d:
  var speed* = 100.0
  var runModifier* = 4.0

  var anim: string
  var animSpeed = 1.0
  var animTween = 0.2
  var autorun = false
  var autorunDir: Vector2
  var velocity: Vector2

  var viewport: Viewport
  var sprite: Sprite
  var model: Spatial
  var animPlayer: AnimationPlayer
  var pivot, camOffset: Node2d
  var cam: Camera2d

  method ready() =
    viewport = getNode("viewport") as Viewport
    sprite = getNode("sprite") as Sprite
    model = viewport.getNode("model") as Spatial
    animPlayer = model.getNode("animationPlayer") as AnimationPlayer
    pivot = getNode("pivot") as Node2d
    camOffset = pivot.getNode("camOffset") as Node2d
    cam = camOffset.getNode("cam") as Camera2d

    sprite.texture = viewport.getTexture()

    animPlayer.getAnimation("Idle").loop = true
    animPlayer.getAnimation("Walk").loop = true

    zoom()

  method physicsProcess(dt: float) =
    velocity = vec2(0, 0)

    var currentSpeed = speed
    var currentAnim = anim
    var currentAnimSpeed = animSpeed

    let strafing = input.isActionPressed("move.strafe")
    if input.isActionJustPressed("move.autorun"): autorun = not autorun

    # cardinals
    if input.isActionPressed("move.up"):
      velocity += UP
    if input.isActionPressed("move.down"):
      velocity += DOWN
    if input.isActionPressed("move.left"):
      velocity += LEFT
    if input.isActionPressed("move.right"):
      velocity += RIGHT
    velocity = velocity.normalized

    if velocity != ZERO and not strafing:
      autorun = false

    if autorun:
      if input.isActionJustPressed("move.autorun"):
        autorunDir = vec2(cos(pivot.rotation), sin(pivot.rotation))
      velocity += autorunDir

    if velocity == ZERO:
      currentAnim = "Idle"
    else:
      var camScalar = 256.0
      if input.isActionPressed("move.sprint"):
        currentSpeed *= runModifier
        currentAnimSpeed *= runModifier
        camScalar *= 2
      camOffset.position = vec2(camScalar * cam.zoom.x, 0)

      currentAnim = "Walk"
      if not strafing:
        pivot.rotation = velocity.angle
        model.rotation = vec3(0, velocity.angle - PI/2, 0)
      velocity = moveAndSlide(velocity.normalized * currentSpeed)

    if currentAnim != anim or input.isActionJustPressed("move.sprint") or input.isActionJustReleased("move.sprint"):
      anim = currentAnim
      animPlayer.play(currentAnim, animTween, currentAnimSpeed)

  method input(event: InputEvent) =
    if input.isActionPressed("cam.zoom-in") and cam.zoom.x > zoomMin:
      zoom(-1)
    if input.isActionPressed("cam.zoom-out") and cam.zoom.x < zoomMax:
      zoom(1)
    if input.isActionJustPressed("interact"):
      discard

  method zoom(scalar: float = 0) {.base.} =
    cam.zoom = cam.zoom + scalar * zoomStep
    camOffset.position = vec2(0, 0)

    let dragMargin = 0.5 * cam.zoom.x
    cam.dragMarginTop = dragMargin
    cam.dragMarginBottom = dragMargin
    cam.dragMarginLeft = dragMargin
    cam.dragMarginRight = dragMargin
