import
  std/strformat,
  std/strutils

import
  ../../adventofcode

const maxRedCubes = 12
const maxGreenCubes = 13
const maxBlueCubes = 14

let input = adventofcode.getInput()
var sum = 0

for line in input.splitLines():
  let colonIdx = line.find(':')
  let gameID = parseInt line[len("Game ") ..< colonIdx]
  let gameSets = line[colonIdx + 2 .. ^1].split("; ")
  block verifyGameSet:
    for gameSet in gameSets:
      for cubeTypeAndCount in gameSet.split(", "):
        let cubeCountAndTypeSplit = cubeTypeAndCount.split(' ')
        let cubeCount = parseInt cubeCountAndTypeSplit[0]
        let cubeType = cubeCountAndTypeSplit[1]
        case cubeType:
          of "red":
            if cubeCount > maxRedCubes:
              break verifyGameSet
          of "green":
            if cubeCount > maxGreenCubes:
              break verifyGameSet
          of "blue":
            if cubeCount > maxBlueCubes:
              break verifyGameSet
          else:
            discard
    sum += gameID

echo fmt"Answer: {sum}"