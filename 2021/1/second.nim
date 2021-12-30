import
  ../../adventofcode,
  sequtils,
  strformat,
  strutils

let input = adventofcode.getInput(2021, 1)
let lines = input.splitLines()[0 .. ^2].mapIt(it.parseInt())

var depths = 0
var prevSum = lines[0] + lines[1] + lines[2]

for idx in 0 .. lines.high():
  if idx + 2 > lines.high(): break

  let currSum = lines[idx] + lines[idx + 1] + lines[idx + 2]
  if prevSum < currSum:
    depths += 1

  prevSum = currSum
  
echo fmt"Answer: {depths}"