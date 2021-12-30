import
  sequtils,
  strutils

type
  Board* = ref object
    grid*: seq[seq[int]]
    marks*: seq[seq[bool]]
    
proc newBoard*(): Board =
  result = Board(
    marks: @[
      @[false, false, false, false, false],
      @[false, false, false, false, false],
      @[false, false, false, false, false],
      @[false, false, false, false, false],
      @[false, false, false, false, false]
    ]
  )
  
proc `$`*(this: Board): string = this.grid.mapIt(it.mapIt($it).join(" ")).join("\n")
  
proc winning*(this: Board): bool =
  for i in 0 .. 4:
    if this.marks.allIt(it[i] == true):
      return true
    if this.marks[i].allIt(it == true):
      return true

proc markNumber*(this: Board, number: int) =
  for i in 0 .. 4:
    for j in 0 .. 4:
      if this.grid[i][j] == number:
        this.marks[i][j] = true
    
proc getUnmarkedNumbers*(this: Board): seq[int] =
  for i in 0 .. 4:
    for j in 0 .. 4:
      if this.marks[i][j] == false:
        result.add this.grid[i][j]