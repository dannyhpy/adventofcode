import
  ../../adventofcode,
  hashes,
  sequtils,
  strutils,
  strformat,
  tables

type
  Grid = TableRef[Point, int]

  HydrothermalVent = object
    x1, x2, y1, y2: int

  Point = object
    x, y: int
    
## https://stackoverflow.com/questions/919612/mapping-two-integers-to-one-in-a-unique-and-deterministic-way
#[
A = a >= 0 ? 2 * a : -2 * a - 1;
B = b >= 0 ? 2 * b : -2 * b - 1;
A >= B ? A * A + A + B : A + B * B;
]#
proc hash(p: Point): Hash =
  let A =
    if p.x >= 0: 2 * p.x
    else: -2 * p.x - 1
  let B =
    if p.y >= 0: 2 * p.y
    else: -2 * p.y - 1
  return
    if A >= B: A * A + A + B
    else: A + B * B

proc getPoints(v: HydrothermalVent): seq[Point] =
  let xd = max(v.x1, v.x2) - min(v.x1, v.x2)
  let yd = max(v.y1, v.y2) - min(v.y1, v.y2)
  when defined(second):
    let xoffset = v.x2 - v.x1
    let yoffset = v.y2 - v.y1

  if xd != 0 and v.y1 == v.y2:
    for i in 0 .. xd:
      result.add Point(x: min(v.x1, v.x2) + i, y: v.y1)

  elif yd != 0 and v.x1 == v.x2:
    for i in 0 .. yd:
      result.add Point(x: v.x1, y: min(v.y1, v.y2) + i)

  else:
    when defined(second):
      # TODO:
      if xoffset < 0:
        for i in 0 .. xd:
          result.add Point(
            x: min(v.x1, v.x2) + i,
            y: max(v.y1, v.y2) - i
          )
      
      else:
        for i in 0 .. yd:
          result.add Point(
            x: max(v.x1, v.x2) + i,
            y: min(v.y1, v.y2) + i
          )
  
proc parseInput(input: string): seq[HydrothermalVent] = 
  for line in input.splitLines()[0 .. ^2]:
    let coords = line.split(" -> ").mapIt(it.split(",").mapIt(it.parseInt()))
    result.add HydrothermalVent(
      x1: coords[0][0], y1: coords[0][1], x2: coords[1][0], y2: coords[1][1] 
    )
    
static:
  let dummyVent = HydrothermalVent(x1: 9, y1: 7, x2: 7, y2: 9)
  for point in dummyVent.getPoints():
    echo $point
  
let input = adventofcode.getInput(2021, 5)
let vents = input.parseInput()
let grid = Grid()

for vent in vents:
  let points = vent.getPoints()
  for point in points:
    if not grid.hasKey point:
      grid[point] = 1
    else:
      grid[point] += 1
      
let overlappingPoints = toSeq(grid.values).countIt(it > 1)
echo fmt"Answer: {overlappingPoints}"