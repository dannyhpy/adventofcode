import
  ../../adventofcode,
  strutils,
  strformat

let input = adventofcode.getInput(2021, 2)
let lines = input.splitLines()

var horizontalPosition = 0
var depth = 0
when defined(second):
  var aim = 0

for line in lines:
  var command = line.split(" ")
  case command[0]:
    of "forward":
      horizontalPosition += command[1].parseInt()
      when defined(second):
        depth += aim * command[1].parseInt()
    of "up":
      when defined(second):
        aim -= command[1].parseInt()
      else:
        depth -= command[1].parseInt()
    of "down":
      when defined(second):
        aim += command[1].parseInt()
      else:
        depth += command[1].parseInt()

echo fmt"Answer: {horizontalPosition * depth}"