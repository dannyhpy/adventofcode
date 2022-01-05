import
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput(2021, 3)
let lines = input.splitLines()

var oxygenGenRateValues = lines
var co2ScrubberRateValues = lines

while oxygenGenRateValues.len() > 1:
  for idx in 0 .. oxygenGenRateValues[0].high():
    let a = oxygenGenRateValues.countIt(it[idx] == '0')
    let b = oxygenGenRateValues.countIt(it[idx] == '1')
    if a == b or a < b:
      oxygenGenRateValues = oxygenGenRateValues.filterIt(it[idx] == '1')
    else:
      oxygenGenRateValues = oxygenGenRateValues.filterIt(it[idx] == '0')

    if oxygenGenRateValues.len() == 1: break
    
while co2ScrubberRateValues.len() > 1:
  for idx in 0 .. co2ScrubberRateValues[0].high():
    let a = co2ScrubberRateValues.countIt(it[idx] == '0')
    let b = co2ScrubberRateValues.countIt(it[idx] == '1')
    if a == b or a < b:
      co2ScrubberRateValues = co2ScrubberRateValues.filterIt(it[idx] == '0')
    else:
      co2ScrubberRateValues = co2ScrubberRateValues.filterIt(it[idx] == '1')
      
    if co2ScrubberRateValues.len() == 1: break

let o2GenRate = oxygenGenRateValues[0].parseBinInt()
let co2ScrubberRate = co2ScrubberRateValues[0].parseBinInt()

echo fmt"Answer: {o2GenRate * co2ScrubberRate}"