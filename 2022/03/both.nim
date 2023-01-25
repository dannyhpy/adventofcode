import
  std/sequtils,
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()

var answer = 0

let itemTypePriorities = block:
  toSeq "-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

when not defined(second):
  for rucksack in input.splitLines:
    let items = toSeq rucksack
    let cmp1 = items[0 ..< items.len() div 2]
    let cmp2 = items[items.len() div 2 .. ^1]

    for item in cmp1:
      if item in cmp2:
        answer += itemTypePriorities.find item
        break
else:
  let inputLines = input.splitLines()

  iterator groups*(): tuple[
    itemList1: seq[char],
    itemList2: seq[char],
    itemList3: seq[char]
  ] =
    var i = 0
    while i < inputLines.len():
      yield (
        toSeq inputLines[i],
        toSeq inputLines[i+1],
        toSeq inputLines[i+2]
      )
      i += 3

  for rucksack1, rucksack2, rucksack3 in groups():
    for item in rucksack1:
      if item notin rucksack2: continue
      if item notin rucksack3: continue
      answer += itemTypePriorities.find item
      break

echo fmt"Answer: {answer}"
