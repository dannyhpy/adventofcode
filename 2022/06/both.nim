import
  std/strformat

import
  ../../adventofcode

let input = adventofcode.getInput()

const markerLen = block:
  when not defined(second):
    4
  else:
    14
var queue = newSeq[char](markerLen)
var answer: int

block process:
  for i in 0 ..< len input:
    let dup = input[i] in queue
    discard queue.pop()
    queue.insert(input[i], 0)
    assert markerLen == len queue

    if not dup and i >= markerLen:
      block check:
        for j in 0 ..< len queue:
          for k in 0 ..< len queue:
            if j == k: continue
            if queue[k] == queue[j]:
              break check

        answer = i + 1
        break process

echo fmt"Answer: {answer}"
