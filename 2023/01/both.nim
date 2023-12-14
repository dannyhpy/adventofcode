import
  std/strformat,
  std/strutils

import
  ../../adventofcode

let input = adventofcode.getInput()
var sum = 0

for line in input.splitLines():
  var digitsInLine: seq[char] = @[]
  for i in 0 .. line.high:
    if line[i].isDigit():
      digitsInLine.add line[i]
    when defined(second):
      # We can't use multiReplace() as numbers can overlap
      # e.g.: eighthree, twone, ...
      proc matches(pattern: string): bool =
        if i + pattern.high <= line.high:
          return line[i .. i + pattern.high] == pattern
      for (a, b) in [
        ("one", '1'),
        ("two", '2'),
        ("three", '3'),
        ("four", '4'),
        ("five", '5'),
        ("six", '6'),
        ("seven", '7'),
        ("eight", '8'),
        ("nine", '9'),
      ]:
        if matches a:
          digitsInLine.add b

  # Take the first and the last digits of the current line
  sum += parseInt(digitsInLine[0] & digitsInLine[^1])

echo fmt"Answer: {sum}"