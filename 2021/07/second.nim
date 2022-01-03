import
  ../../adventofcode,
  math,
  sequtils,
  strformat,
  strutils
  
let input = adventofcode.getInput(2021, 7)
#let input = "16,1,2,0,4,2,7,1,2,14" # Example given
let crabs = input.split(",").mapIt(it.parseInt())

let avg = toInt math.floor((math.sum crabs) / crabs.len())

var fuel = 0
for crab in crabs:
  let distance = max(crab, avg) - min(crab, avg)
  fuel += sum toSeq 1 .. distance
    
echo fmt"Position     : {avg}"
echo fmt"Fuel | Answer: {fuel}"