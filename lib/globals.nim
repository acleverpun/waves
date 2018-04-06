import godot

template debug*(values: varargs[string, `$`]): typed =
  if input.isActionPressed("debug"): print values.join("\t")

template ifDebug*(body: untyped): typed =
  if input.isActionPressed("debug"): body
