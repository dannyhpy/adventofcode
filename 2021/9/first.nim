import
  ../../adventofcode,
  math,
  options,
  sequtils,
  strformat,
  strutils
  
type
  Grid = seq[seq[int]]
  
proc at(g: Grid; x, y: int): Option[int] =
  try: result = some g[y][x]
  except IndexDefect: discard
  
let input = adventofcode.getInput(2021, 9)
let grid = Grid input.splitLines().mapIt(toSeq(it).mapIt(($it).parseInt()))

var lowPoints = newSeq[int]()

for y in 0 .. grid.high():
  for x in 0 .. grid[y].high():
    let p = grid.at(x, y).get()

    let adjA = grid.at(x - 1, y)
    if adjA.isSome() and p >= adjA.get(): continue
    let adjB = grid.at(x, y - 1)
    if adjB.isSome() and p >= adjB.get(): continue
    let adjC = grid.at(x + 1, y)
    if adjC.isSome() and p >= adjC.get(): continue
    let adjD = grid.at(x, y + 1)
    if adjD.isSome() and p >= adjD.get(): continue
      
    lowPoints.add p

var riskLevels = lowPoints.mapIt(it + 1)

echo fmt"Answer: {math.sum riskLevels}"