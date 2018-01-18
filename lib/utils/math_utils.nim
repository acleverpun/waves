import math

proc lerp*(a, b, t: float): float =
  (1 - t) * a + t * b

proc lerpAngle*(a, b, t: float): float =
  var cs = (1 - t) * cos(a) + t * cos(b)
  var sn = (1 - t) * sin(a) + t * sin(b)
  arctan2(sn, cs)
