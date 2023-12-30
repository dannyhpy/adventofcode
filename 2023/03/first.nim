import
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()
var sum = 0

var schematic: seq[seq[char]] = input.splitLines().mapIt(toSeq it)

for y in 0 .. schematic.high():
  var numStr = ""
  for x in 0 .. schematic[y].high():
    block wholeChara:
      let chara = schematic[y][x]
      if not chara.isDigit():
        numStr.reset()
        continue
      numStr &= chara

      if x == schematic[y].high() or not schematic[y][x + 1].isDigit():
        # x = end index
        var adjacentPositions: seq[(int, int)] = @[]
        for i in 0 .. numStr.high():
          # up, down
          adjacentPositions.add (x - numStr.high() + i, y - 1)
          adjacentPositions.add (x - numStr.high() + i, y + 1)
        for dy in -1 .. 1:
          # left, right
          adjacentPositions.add (x - numStr.high() - 1, y + dy)
          adjacentPositions.add (x + 1, y + dy)

        for pos in adjacentPositions:
          if pos[0] < 0 or pos[0] > schematic[y].high(): continue
          if pos[1] < 0 or pos[1] > schematic.high(): continue
          let charaToCheck = schematic[pos[1]][pos[0]]
          if not charaToCheck.isDigit() and charaToCheck != '.':
            sum += numStr.parseInt()
            break wholeChara

echo fmt"Answer: {sum}"