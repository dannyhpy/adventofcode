import
  std/strformat,
  std/strutils,
  std/tables

import
  ../../adventofcode

let input = adventofcode.getInput()

var score = 0

type
  Choices = enum
    rock, paper, scissors

let choices = toTable({
  'A': rock,
  'B': paper,
  'C': scissors,
  'X': rock,
  'Y': paper,
  'Z': scissors,
})

for line in input.splitLines:
  let opponentChoice = choices[line[0]]
  let ourChoice = choices[line[2]]

  # The choice we make is added to the score
  score += 1 + ord ourChoice

  let outcome = ord(ourChoice) - ord(opponentChoice)
  case outcome
  of -2: score += 6
  of -1: score += 0
  of 0: score += 3
  of 1: score += 6
  of 2: score += 0
  else:
    raise newException(ValueError, fmt"Outcome: {outcome}")

echo fmt"Answer: {score}"
