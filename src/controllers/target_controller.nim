include globals

import
  collision_shape_2d,
  node,
  node_2d,
  rich_text_label

type Target* = ref object
  node*: Node2d
  collision*: CollisionShape2d
  position*: Vector2

proc findCollision(node: Node2d): CollisionShape2d =
  if node.hasNode("collision"): return node.getNode("collision") as CollisionShape2d
  if node.hasNode("collisionShape2D"): return node.getNode("collisionShape2D") as CollisionShape2d

proc newTarget*(node: Node2d): Target =
  let collision = findCollision(node)

  Target(
    node: node,
    collision: collision,
    position: node.position + collision.position,
  )

gdobj TargetController of Node:
  var target*: Target

  var ui: Node
  var targetText: RichTextLabel

  method ready() =
    ui = getNode("../area/ui")
    targetText = ui.findNode("target") as RichTextLabel

  proc setTarget*(node: Node2d) =
    target = newTarget(node)
    targetText.text = target.node.name

  proc clearTarget*() =
    target = nil
    targetText.text = nil

  proc hasTarget*(): bool =
    target != nil
