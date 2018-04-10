import godot

import strutils

template debug*(values: varargs[string, `$`]): typed =
  if input.isActionPressed("debug"): print values.join("\t")

template ifDebug*(body: untyped): typed =
  if input.isActionPressed("debug"): body

template debugOnce*(values: varargs[string, `$`]): typed =
  if input.isActionJustPressed("debug"): print values.join("\t")

template ifDebugOnce*(body: untyped): typed =
  if input.isActionJustPressed("debug"): body

const
  LEFT* = vec3(-1, 0, 0)
  RIGHT* = vec3(1, 0, 0)
  FORWARD* = vec3(0, 0, -1)
  BACKWARD* = vec3(0, 0, 1)
  UP* = vec3(0, 1, 0)
  DOWN* = vec3(0, -1, 0)
  ZERO* = vec3(0, 0, 0)
