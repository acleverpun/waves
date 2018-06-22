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
  var runMod* = 2.0
  var camDistance* = 128.0
  var deadzone* = 0.3

  var anim: string
  var animSpeed = 1.0
  var animTween = 0.2
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

  method input(event: InputEvent) =
    if input.isActionPressed("cam.zoom-in") and cam.zoom.x > zoomMin:
      zoom(-1)
    if input.isActionPressed("cam.zoom-out") and cam.zoom.x < zoomMax:
      zoom(1)
    if input.isActionJustPressed("interact"):
      discard

  method physicsProcess(dt: float) =
    movement(dt)
    actions(dt)

  method movement(dt: float) {.base.} =
    velocity = ZERO

    var speedMod = 1.0
    var currentAnim = anim
    var isGamepad = false

    if input.isJoyKnown(0):
      velocity = vec2(input.getJoyAxis(0, 0), input.getJoyAxis(0, 1))
      if velocity.length >= deadzone: isGamepad = true
      else: velocity = ZERO

    # cardinals
    if input.isActionPressed("move.up"):
      velocity += UP
    if input.isActionPressed("move.down"):
      velocity += DOWN
    if input.isActionPressed("move.left"):
      velocity += LEFT
    if input.isActionPressed("move.right"):
      velocity += RIGHT

    velocity = velocity.clamped(1)

    if velocity == ZERO:
      currentAnim = "Idle"
    else:
      if input.isActionPressed("move.sprint"):
        speedMod = runMod
      camOffset.position = vec2(camDistance * speedMod * cam.zoom.x, 0)

      currentAnim = "Walk"
      pivot.rotation = velocity.angle
      model.rotation = vec3(0, velocity.angle - PI/2, 0)
      if not input.isActionPressed("move.halt"):
        velocity = moveAndSlide(velocity * speed * speedMod)

    if currentAnim != anim or input.isActionJustPressed("move.sprint") or input.isActionJustReleased("move.sprint"):
      anim = currentAnim
      animPlayer.play(currentAnim, animTween, animSpeed * speedMod)

  method actions(dt: float) {.base.} =
    if input.isActionPressed("action.1"):
      print true

  method zoom(scalar: float = 0) {.base.} =
    cam.zoom = cam.zoom + scalar * zoomStep
    camOffset.position = vec2(0, 0)

    let dragMargin = 0.5 * cam.zoom.x
    cam.dragMarginTop = dragMargin
    cam.dragMarginBottom = dragMargin
    cam.dragMarginLeft = dragMargin
    cam.dragMarginRight = dragMargin
