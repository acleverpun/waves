include globals

import
  node_2d

gdobj Selectable of Node2d:
  var parent: Node2d

  method ready() =
    parent = getParent() as Node2d
