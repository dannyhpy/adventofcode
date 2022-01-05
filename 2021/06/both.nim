import
  std/math,
  std/sequtils,
  std/strformat,
  std/strutils,
  std/tables

import
  ../../adventofcode
  
type
  Cycle = int

let input = adventofcode.getInput(2021, 6)

var days = 0
var fishes: Table[Cycle, int]
for i in 0 .. 8:
  fishes[i] = 0

proc parseInput() =
  let cycles = input.split(",").mapIt(it.parseInt())
  for cycle in cycles:
    fishes[cycle] += 1

proc newDay() =
  days += 1
  
  var temporaryBox: Table[Cycle, int]
  for i in 0 .. 8:
    temporaryBox[i] = 0

  for cycle in [8, 7, 6, 5, 4, 3, 2, 1]:
    let count = fishes[cycle]
    fishes[cycle] -= count
    temporaryBox[cycle - 1] += count
    
  block cycle0:
    let count = fishes[0]
    fishes[0] -= count
    temporaryBox[6] += count
    temporaryBox[8] += count
    
  for cycle in temporaryBox.keys():
    fishes[cycle] += temporaryBox[cycle]
      
when isMainModule:
  const simulateDays = block:
    when defined(second): 256
    else: 80

  parseInput()
  for i in 1 .. simulateDays:
    newDay()

  echo fmt"{days} days passed."
  echo fmt"Answer: {math.sum toSeq fishes.values()}"