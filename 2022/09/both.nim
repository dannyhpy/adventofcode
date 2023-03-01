import
  std/strformat,
  std/strutils

import
  ../../adventofcode

type
  Position = tuple[x, y: int]

let input = adventofcode.getInput()

var knots: seq[Position] = @[]
const knotCount =
  when not defined(second): 2
  else: 10
for i in 0 ..< knotCount:
  knots.add (0, 0)

var visitedByLastKnot: seq[Position] = @[(0, 0)]

for line in input.splitLines():
  let direction = line[0]
  let moves = parseInt line[2 .. ^1]
  for i in 0 ..< moves:
    case direction
    of 'L': knots[0].x -= 1
    of 'R': knots[0].x += 1
    of 'U': knots[0].y -= 1
    of 'D': knots[0].y += 1
    else: discard

    for i in 1 ..< len knots:
      let dx = knots[i - 1].x - knots[i].x
      let dy = knots[i - 1].y - knots[i].y
      let tension = abs(dx) > 1 or abs(dy) > 1
      if tension:
        if abs(dx) > 0:
          let moveKnotX = if dx > 0: 1 else: -1
          knots[i].x += moveKnotX
        if abs(dy) > 0:
          let moveKnotY = if dy > 0: 1 else: -1
          knots[i].y += moveKnotY

        if i == high knots:
          if knots[i] notin visitedByLastKnot:
            visitedByLastKnot.add knots[i]

echo fmt"Answer: {len visitedByLastKnot}"
