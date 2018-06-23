type Action*[T] = ref object
  player: T

proc newAction*[T](player: T): Action[T] =
  new(result)
  result.player = player

method activate*(self: Action) {.base, gcsafe.} =
  echo self.player.velocity
