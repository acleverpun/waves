include globals

import
  node,
  rich_text_label

gdobj TargetController of Node:
  var target* {.gdExport, hint: NodePathToEditedNode.}: Node

  var ui: Node
  var targetText: RichTextLabel

  method ready() =
    ui = getNode("../area/ui")
    targetText = ui.findNode("target") as RichTextLabel

  proc setTarget*(node: Node) =
    target = node
    targetText.text = target.name

  proc clearTarget*() =
    target = nil
    targetText.text = nil

  proc hasTarget*(): bool =
    target != nil
