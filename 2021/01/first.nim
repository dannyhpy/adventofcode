import
  ../../adventofcode,
  sequtils,
  strformat,
  strutils

let input = adventofcode.getInput(2021, 1)
let lines = input.splitLines().mapIt(it.parseInt())

var depths = 0
var prevResult = lines[0]

for line in lines[1 .. ^1]:
  let currResult = line
  if prevResult < currResult:
    depths += 1

  prevResult = currResult
  
echo fmt"Answer: {depths}"