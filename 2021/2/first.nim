import
  ../../adventofcode,
  strutils,
  strformat

let input = adventofcode.getInput(2021, 2)
let lines = input.splitLines()[0 .. ^2]

var horizontalPosition = 0
var depth = 0

for line in lines:
  var command = line.split(" ")
  case command[0]:
    of "forward":
      horizontalPosition += command[1].parseInt()
    of "up":
      depth -= command[1].parseInt()
    of "down":
      depth += command[1].parseInt()

echo fmt"Answer: {horizontalPosition * depth}"