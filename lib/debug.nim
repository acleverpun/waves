template debug*(values: varargs[string, `$`]): typed =
  if input.isActionPressed("debug"): print values.join("\t")

template ifDebug*(body: untyped): typed =
  if input.isActionPressed("debug"): body

template debugOnce*(values: varargs[string, `$`]): typed =
  if input.isActionJustPressed("debug"): print values.join("\t")

template ifDebugOnce*(body: untyped): typed =
  if input.isActionJustPressed("debug"): body
