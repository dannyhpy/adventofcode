import
  std/strformat,
  std/strutils,
  std/tables
  
when defined(second):
  import std/algorithm

import
  ../../adventofcode

let input = adventofcode.getInput(2021, 10)
let lines = input.splitLines()

const chunkSymbols = (
  open: {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>'
  }.toTable(),
  close: {
    ')': '(',
    ']': '[',
    '}': '{',
    '>': '<'
  }.toTable()
)

when not defined(second):
  const chunkScores = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137
  }.toTable()
else:
  const chunkScores = {
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4
  }.toTable()

var score = 0
when defined(second):
  var lineScores: seq[int]

for line in lines:
  var chunks: seq[char]

  block abortLine: 
    for it in line:
      if chunkSymbols.open.hasKey it:
        chunks.add it
      
      if chunkSymbols.close.hasKey it:
        let expectedSymbol = chunkSymbols.open[chunks[^1]]
        if it == expectedSymbol:
          discard chunks.pop()
        else:
          # Line is corrupted.
          when not defined(second):
            score += chunkScores[it]
          break abortLine
          
    # Complete line by closing chunks
    when defined(second):
      var lineScore = 0

      for idx in 0 .. chunks.high():
        let it = chunks[chunks.high() - idx]
        let closeSym = chunkSymbols.open[it]
        lineScore *= 5
        lineScore += chunkScores[closeSym]

      lineScores.add lineScore

when defined(second):
  lineScores.sort()
  score = lineScores[lineScores.len() div 2]

echo fmt"Answer: {score}"