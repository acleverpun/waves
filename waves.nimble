version = "0.0.0"
author = "Ross Hadden"
description = "Waves, a Godot game"
license = "MIT"

srcDir = "src"
skipDirs = @[
  "entities",
  "scenes",
  "utils",
]
skipFiles = @[
  "global.nim",
]

requires "godot >= 0.7.8 & < 0.8.0"
