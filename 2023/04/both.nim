import
  std/math,
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()

when not defined(second):
  var points = 0
else:
  var additionalCards: seq[Natural] = @[]

let lines = input.splitLines()
for i in 0 .. lines.high():
  let line = lines[i]
  when defined(second):
    if additionalCards.high() < i:
      additionalCards.add 0
    let instances = 1 + additionalCards[i]
  let winningNumsStart = line.find(':') + 1
  let winningNumsEnd = line.find('|')
  let winningNums = line[winningNumsStart ..< winningNumsEnd]
    .split(' ')
    .filterIt(it != "")
    .mapIt(parseInt it)
  let elfNums = line[winningNumsEnd + 1 .. ^1]
    .split(' ')
    .filterIt(it != "")
    .mapIt(parseInt it)

  var duplicata = 0
  for n in elfNums:
    if n in winningNums:
      duplicata.inc()

  when not defined(second):
    if duplicata > 0:
      points += 2 ^ (duplicata - 1)
  else:
    for j in 1 .. duplicata:
      if additionalCards.high() < i + j:
        additionalCards.add 0
      additionalCards[i + j] += instances

when not defined(second):
  echo fmt"Answer: {points}"
else:
  var originalCardCount = len(lines)
  var additionalCardSum = sum(additionalCards)
  echo fmt"Answer: {originalCardCount + additionalCardSum}"