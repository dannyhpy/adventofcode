import
  std/strformat,
  std/strutils

import
  ../../adventofcode

type
  Map = seq[seq[int]]
proc `[]`(m: Map; x, y: Natural): int =
  result = m[y][x]

let input = adventofcode.getInput()
var map: seq[seq[int]] = @[]

let lines = input.splitLines()
for y in 0 ..< lines.len():
  map.add(@[])
  for x in 0 ..< lines[y].len():
    map[y].add parseInt($lines[y][x])

var highestScore: int = 0

for y in 0 ..< map.len():
  for x in 0 ..< map[y].len():
    if (x == 0) or (y == 0) or (x == map[y].high()) or (y == map.high()):
      continue

    let height = map[x, y]

    var leftScore = 0
    for x2 in countdown(x - 1, 0):
      let h = map[x2, y]
      leftScore.inc()
      if h >= height:
        break

    var rightScore = 0
    for x3 in countup(x + 1, high map[y]):
      let h = map[x3, y]
      rightScore.inc()
      if h >= height:
        break

    var topScore = 0
    for y2 in countdown(y - 1, 0):
      let h = map[x, y2]
      topScore.inc()
      if h >= height:
        break

    var bottomScore = 0
    for y3 in countup(y + 1, high map):
      let h = map[x, y3]
      bottomScore.inc()
      if h >= height:
        break

    var score = leftScore * rightScore * topScore * bottomScore
    if score > highestScore:
      highestScore = score

echo fmt"Answer: {highestScore}"
