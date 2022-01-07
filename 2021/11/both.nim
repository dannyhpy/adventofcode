import
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode
  
let input = adventofcode.getInput(2021, 11)
var grid: seq[seq[int]] = block:
  input.splitLines().mapIt(it.mapIt(parseInt $it))
  
var steps = 0
var flashes = 0
  
proc inc(row, col: int)
proc flash(row, col: int)
  
proc inc(row, col: int) =
  try:
    grid[row][col] += 1
    if grid[row][col] == 10:
      flash(row, col)
  except IndexDefect: return
  
proc flash(row, col: int) =
  flashes += 1
  inc(row, col - 1)
  inc(row, col + 1)
  inc(row - 1, col)
  inc(row + 1, col)
  inc(row - 1, col - 1)
  inc(row + 1, col + 1)
  inc(row - 1, col + 1)
  inc(row + 1, col - 1)

proc resetFlashes() =
  for row in 0 .. grid.high():
    for col in 0 .. grid[row].high():
      if grid[row][col] > 9:
        grid[row][col] = 0
        
when defined(second):
  proc areTheyAllFlashing(): bool =
    result = true
    for row in 0 .. grid.high():
      for col in 0 .. grid[row].high():
        if grid[row][col] != 0:
          return false
  
proc forwardStep() =
  steps += 1
  for row in 0 .. grid.high():
    for col in 0 .. grid[row].high():
      inc(row, col)
  resetFlashes()
      
when not defined(second):
  while steps < 100:
    forwardStep()

  echo fmt"Answer: {flashes}"
else:
  while not areTheyAllFlashing():
    forwardStep()

  echo fmt"Answer: {steps}"
