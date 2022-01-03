import
  ../../adventofcode,
  options,
  sequtils,
  strformat,
  strutils
  
let input = adventofcode.getInput(2021, 7)[0 .. ^2]
#let input = "16,1,2,0,4,2,7,1,2,14" # Example given
let crabs = input.split(",").mapIt(it.parseInt())
let minPos = min(crabs)
let maxPos = max(crabs)

var bestPosResult = none int
var bestFuelResult = none int

for pos in minPos .. maxPos:
  var fuel = 0
  for crab in crabs:
    fuel += max(crab, pos) - min(crab, pos)
    
  if bestFuelResult.isNone() or fuel < bestFuelResult.get():
    bestPosResult = some pos
    bestFuelResult = some fuel
  
echo fmt"Position     : {bestPosResult.get()}"
echo fmt"Fuel | Answer: {bestFuelResult.get()}"