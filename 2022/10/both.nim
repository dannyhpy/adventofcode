import
  std/strutils

import
  ../../adventofcode

when not defined(second):
  import
    std/strformat

let input = adventofcode.getInput()
let instructions = input.splitLines()

var registerX = 1
var currOpIdx = 0
var currOp = ""
var currOpArg = 0
var sameOpN = 0
proc endOp() =
  reset currOp
  reset currOpArg
  reset sameOpN
  currOpIdx.inc()

when not defined(second):
  const rangeEnd = 220
  var answer = 0
else:
  const rangeEnd = high(int)
  var crtOutput = ""

for n in 1 .. rangeEnd:
  when not defined(second):
    if (n + 20) mod 40 == 0:
      when not defined(release):
        echo fmt"{ n = }, { registerX = }"
      answer += n * registerX
  else:
    # Because the cycle count `n` starts at 1
    let a = n - 1

    # Only generate a 40x6 image
    if a < 40 * 6:
      if a mod 40 == 0:
        crtOutput.add '\n'

      if a mod 40 in registerX - 1 .. registerX + 1:
        crtOutput.add '#'
      else:
        crtOutput.add '.'

  if currOp == "":
    if currOpIdx > high instructions:
      break
    let opArgs = splitWhitespace instructions[currOpIdx]
    currOp = opArgs[0]
    if opArgs.len() == 2:
      currOpArg = parseInt opArgs[1]

  case currOp
  of "addx":
    if sameOpN == 1:
      registerX += currOpArg
      endOp()
  of "noop":
    endOp()
  else:
    discard

  if currOp != "":
    sameOpN.inc()


when not defined(second):
  echo fmt"Answer: {answer}"
else:
  echo crtOutput
