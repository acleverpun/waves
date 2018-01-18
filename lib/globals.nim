import godot

template debug*(values: varargs[string, `$`]): typed =
  if input.isActionPressed("debug"): print values.join("\t")

template ifDebug*(body: untyped): typed =
  if input.isActionPressed("debug"): body

proc `+`*(a, b: Vector2): Vector2 = a - -b
proc `+=`*(a: var Vector2, b: Vector2) = a -= -b
