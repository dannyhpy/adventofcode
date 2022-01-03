import
  ../../adventofcode,
  math,
  sequtils,
  strutils,
  strformat
  
import
  x/board
  
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
    
var winningBoards: seq[Board]
while currentlyDrawn.len() != drawn.len() and winningBoards.len() < boards.len():
  let next = drawn[currentlyDrawn.len()]
  currentlyDrawn.add next
  
  for board in boards:
    board.markNumber next
    
    if board.winning and not winningBoards.contains board:
      winningBoards.add board

let lastWinningBoard = winningBoards[^1]
let lastWinningBoardScore = currentlyDrawn[^1] * math.sum lastWinningBoard.getUnmarkedNumbers()

echo fmt"Boards: {boards.len()}"
echo fmt"Answer: {lastWinningBoardScore}"