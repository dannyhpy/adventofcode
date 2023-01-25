import
  std/strformat,
  std/strutils,
  std/tables

import
  ../../adventofcode

let input = adventofcode.getInput()

var score = 0

type
  Choice = enum
    cRock = 'A',
    cPaper = 'B',
    cScissors = 'C'
  RequiredOutcome = enum
    roDefeat = 'X',
    roDraw = 'Y',
    roVictory = 'Z'

let choiceScores = toTable({
  cRock: 1,
  cPaper: 2,
  cScissors: 3,
})

for line in input.splitLines:
  let opponentChoice = Choice line[0]
  let requiredOutcome = RequiredOutcome line[2]
  var ourChoice: Choice
  
  case requiredOutcome
  of roDefeat:
    score += 0
    case opponentChoice
    of cRock:
      ourChoice = cScissors
    of cPaper:
      ourChoice = cRock
    of cScissors:
      ourChoice = cPaper
  of roDraw:
    score += 3
    ourChoice = opponentChoice
  of roVictory:
    score += 6
    case opponentChoice
    of cRock:
      ourChoice = cPaper
    of cPaper:
      ourChoice = cScissors
    of cScissors:
      ourChoice = cRock

  # The choice we make is added to the score
  score += choiceScores[ourChoice]

echo fmt"Answer: {score}"
