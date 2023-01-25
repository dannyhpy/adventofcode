import
  std/algorithm,
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()
let lines = input.splitLines()

var stacks = newSeq[seq[char]]()

let sepIdx = lines.find("")
assert sepIdx != -1
let drawInstructions = lines[0 ..< sepIdx]
let moveInstructions = lines[sepIdx + 1 .. ^1]

when not defined(release):
  proc echoRepr(stacks: seq[seq[char]]) =
    let m = max stacks.mapIt(high it)
    for i in countdown(m, 0):
      echo join(stacks.map(proc(it: seq[char]): string =
        if it.high < i: return "   "
        return fmt"[{it[i]}]"
      ), sep=" ")
      
    echo " " & join(toSeq {1 .. stacks.high() + 1}, "   ") & " "
    
for line in reversed drawInstructions:
  if line.startsWith(" 1 "):
    for n in line.splitWhitespace().mapIt(parseInt it):
      assert n - 1 == len stacks
      stacks.add(@[])
  else:
    var containers = newSeq[string]()
    for i in countup(0, line.len - 2, 4):
      containers.add line[i ..< i + 3]
    for i in 0 ..< containers.len():
      let cnt = containers[i]
      if cnt[1] == ' ': continue
      stacks[i].add cnt[1]

when not defined(release) and defined(stepByStep):
  echoRepr stacks
  echo ""

for line in moveInstructions.mapIt(it.splitWhitespace()):
  when not defined(release) and defined(stepByStep):
    echo line
    echo ""

  let howMany = parseInt line[1]
  var srcStack = parseInt line[3]
  srcStack.dec()
  var destStack = parseInt line[5]
  destStack.dec()

  assert howMany <= len stacks[srcStack]

  let sliceStart = stacks[srcStack].len() - howMany
  let sliceEnd = stacks[srcStack].len() - 1
  let movedItems = block:
    when not defined(second):
      reversed stacks[srcStack][sliceStart .. sliceEnd]
    else:
      stacks[srcStack][sliceStart .. sliceEnd]
  stacks[srcStack].delete(sliceStart .. sliceEnd)
  stacks[destStack] &= movedItems

  when not defined(release) and defined(stepByStep):
    echoRepr stacks
    echo ""
    echo "Press ENTER to continue."
    discard stdin.readChar()
    echo ""

when not defined(release):
  echoRepr stacks
  echo ""

let answer = join(stacks.mapIt it[high it])
echo fmt "Answer: {answer}"
