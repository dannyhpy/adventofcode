import
  std/strformat,
  std/strutils

when defined(second):
  import
    std/algorithm,
    std/math

import
  ../../adventofcode

let input = adventofcode.getInput()

when not defined(second):
  var mostCalories = 0
else:
  var elveCalories: seq[int]

let inventories = input.split("\L\L")
for inventory in inventories:
  var calories = 0
  let items = inventory.split("\L")
  for item in items:
    calories += item.parseInt()

  when not defined(second):
    mostCalories = max(mostCalories, calories)
  else:
    elveCalories.add calories

when not defined(second):
  echo fmt"Answer: {mostCalories}"
else:
  elveCalories.sort(order=Descending)
  
  let totalCalories = sum elveCalories[0 ..< 3]
  echo fmt"Answer: {totalCalories}"
