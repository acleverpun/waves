when not defined(release):
  import segfaults # converts segfaults into NilAccessError

import components/selectable
import controllers/debug_controller
import controllers/target_controller
import entities/actors/player
import scenes/area
