import
  std/math,
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode,
  ./x/board
  
let input = adventofcode.getInput(2021, 4)
let lines = input.splitLines()

let drawn = lines[0].split(",").mapIt(it.parseInt())
var currentlyDrawn: seq[int] = @[]
var boards: seq[Board] = @[]

# Determinate boards from our input
var currBoard = newBoard()
for line in lines[2 .. ^1]:
  if line.len() != 0:
    currBoard.grid.add line.split(" ").filterIt(it.len() > 0).mapIt(it.parseInt())
    
  else:
    boards.add currBoard
    currBoard = newBoard()
    
var determinatedWinner = false
var winningBoard: Board
while not determinatedWinner:
  if currentlyDrawn.len() == drawn.len():
    # We run out of numbers to draw
    break

  let next = drawn[currentlyDrawn.len()]
  currentlyDrawn.add next
  
  for board in boards:
    board.markNumber next
    
    if board.winning:
      winningBoard = board
      determinatedWinner = true
      break

echo $winningBoard
let winningBoardScore = currentlyDrawn[^1] * math.sum winningBoard.getUnmarkedNumbers()

echo fmt"Boards: {boards.len()}"
echo fmt"Answer: {winningBoardScore}"