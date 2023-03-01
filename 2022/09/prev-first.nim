import
  std/strformat,
  std/strutils

import
  ../../adventofcode

type
  Position = tuple[x, y: int]

let input = adventofcode.getInput()

var lastHead: Position = (0, 0)
var head: Position = (0, 0)
var tail: Position = (0, 0)
var visited: seq[Position] = @[(0, 0)]

for line in input.splitLines():
  let direction = line[0]
  let moves = parseInt line[2 .. ^1]
  for i in 0 ..< moves:
    lastHead = head
    case direction
    of 'L': head.x -= 1
    of 'R': head.x += 1
    of 'U': head.y -= 1
    of 'D': head.y += 1
    else: discard

    var tension = abs(head.x - tail.x) > 1 or abs(head.y - tail.y) > 1
    if tension:
      tail = lastHead
      if tail notin visited:
        visited.add tail

echo fmt"Answer: {len visited}"
