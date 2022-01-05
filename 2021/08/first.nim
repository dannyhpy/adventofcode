import
  std/math,
  std/sequtils,
  std/strformat,
  std/strutils,
  std/tables

import
  ../../adventofcode

let lines = adventofcode.getInput(2021, 8).splitLines()
var decodedDigits = newTable[int, int]()
for i in [2, 3, 4, 7]:
  decodedDigits[i] = 0

for line in lines:
  let lineParts = line.split(" | ")

  # We only consider output digits for now
  let outputDigits = lineParts[1].split(" ")

  for outputDigit in outputDigits:
    if decodedDigits.hasKey outputDigit.len():
      decodedDigits[outputDigit.len()] += 1

echo fmt"Answer: {math.sum toSeq decodedDigits.values()}"