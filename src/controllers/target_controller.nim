include globals

import
  node,
  node_2d,
  rich_text_label

gdobj TargetController of Node:
  var target* {.gdExport, hint: NodePathToEditedNode.}: Node2d

  var ui: Node
  var targetText: RichTextLabel

  method ready() =
    ui = getNode("../area/ui")
    targetText = ui.findNode("target") as RichTextLabel

  proc setTarget*(node: Node2d) =
    target = node
    targetText.text = target.name

  proc clearTarget*() =
    target = nil
    targetText.text = nil

  proc hasTarget*(): bool =
    target != nil
