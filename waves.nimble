version = "0.0.0"
author = "Ross Hadden"
description = "A 2D wave survival adventure rpg game"
license = "MIT"

srcDir = "src"
skipDirs = @[
  "components",
  "controllers",
  "entities",
  "scenes",
  "utils",
]
skipFiles = @[
  "debug.nim",
  "globals.nim",
]

requires "godot >= 0.7.8 & < 0.8.0"
