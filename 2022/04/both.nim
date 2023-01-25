import
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()

var score = 0

for pair in input.splitLines:
  let sepIdx = pair.find(',')
  assert sepIdx != -1

  let range1Str = pair[0 ..< sepIdx]
  let range2Str = pair[sepIdx + 1 .. ^1]
  var range1: set[0 .. 65535]
  var range2: set[0 .. 65535]

  for i in 0 .. 1:
    let rangeStr = block:
      if i == 0: range1Str
      else: range2Str
    let rangeStrSepIdx = rangeStr.find('-')
    assert rangeStrSepIdx != -1
    let rangeStart = parseInt rangeStr[0 ..< rangeStrSepIdx]
    let rangeEnd = parseInt rangeStr[rangeStrSepIdx + 1 .. ^1]
    if i == 0: range1 = {rangeStart .. rangeEnd}
    else: range2 = {rangeStart .. rangeEnd}

  var total = range1 + range2
  when not defined(second):
    if range1.len == total.len or range2.len == total.len:
      score += 1
  else:
    if total.len != (range1.len + range2.len):
      score += 1

echo fmt"Answer: {score}"

