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

var visibleTrees = 0

for y in 0 ..< map.len():
  for x in 0 ..< map[y].len():
    if (x == 0) or (y == 0) or (x == map[y].high()) or (y == map.high()):
      visibleTrees.inc()
      continue

    let height = map[x, y]
    block check:

      block left:
        for x2 in countdown(x - 1, 0):
          let h = map[x2, y]
          if h >= height:
            break left
        visibleTrees.inc()
        break check

      block right:
        for x3 in countup(x + 1, high map[y]):
          let h = map[x3, y]
          if h >= height:
            break right
        visibleTrees.inc()
        break check

      block top:
        for y2 in countdown(y - 1, 0):
          let h = map[x, y2]
          if h >= height:
            break top
        visibleTrees.inc()
        break check

      block bottom:
        for y3 in countup(y + 1, high map):
          let h = map[x, y3]
          if h >= height:
            break bottom
        visibleTrees.inc()
        break check

echo fmt"Answer: {visibleTrees}"
