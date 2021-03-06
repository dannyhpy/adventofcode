import
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput(2021, 3)
let lines = input.splitLines()

var gammaRateBinary = ""
var epsilonRateBinary = ""

for idx in 0 .. lines[0].high():
  let a = lines.countIt(it[idx] == '0')
  let b = lines.countIt(it[idx] == '1')
  if a > b:
    gammaRateBinary.add '0'
    epsilonRateBinary.add '1'
  else:
    gammaRateBinary.add '1'
    epsilonRateBinary.add '0'
    
let gammaRate = gammaRateBinary.parseBinInt()
let epsilonRate = epsilonRateBinary.parseBinInt()

echo fmt"Answer: {gammaRate * epsilonRate}"