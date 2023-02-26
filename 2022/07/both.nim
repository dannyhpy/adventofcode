import
  std/strutils,
  std/strformat,
  std/tables

import
  ../../adventofcode

proc `/`(base, tail: string): string =
  if tail == "..":
    let sep = base.rfind('/')
    if sep > 0: return base[0 ..< sep]
    else: return "/"
  else:
    if base[^1] == '/':
      return base & tail
    else:
      return base & "/" & tail

type
  PseudoFileKind = enum
    pfFile, pfDir
  PseudoFile = ref object
    case kind: PseudoFileKind
    of pfFile:
      size: Natural
    of pfDir:
      fileNames: seq[string]
proc newPseudoFile(size: Natural = 0): PseudoFile =
  result = PseudoFile(kind: pfFile, size: size)
proc newPseudoDir(): PseudoFile =
  result = PseudoFile(kind: pfDir)

let input = adventofcode.getInput()
var files = initTable[string, PseudoFile]()
var dirSizes = initTable[string, Natural]()
var cwd = "/"
var cwdObj = newPseudoDir()
files["/"] = cwdObj

proc computeSize(path: string): Natural =
  if not files.hasKey path: return
  let file = files[path]
  case file.kind
  of pfFile: return file.size
  of pfDir:
    if dirSizes.hasKey path:
      return dirSizes[path]
    for name in file.fileNames:
      result += computeSize(path / name)
    dirSizes[path] = result

for line in input.splitLines:
  let args = line.splitWhitespace()
  if args[0] == "$":
    if args[1] == "cd":
      if args[2][0] == '/':
        cwd = args[2]
      else:
        cwd = cwd / args[2]
      when not defined(release):
        echo fmt"{cwd = }"
      
      if files.hasKey cwd:
        cwdObj = files[cwd]
      else:
        cwdObj = newPseudoDir()
      files[cwd] = cwdObj
  else:
    if args[1] notin cwdObj.fileNames:
      cwdObj.fileNames.add args[1]
    if args[0] == "dir":
      let dir = newPseudoDir()
      files[cwd / args[1]] = dir
    else:
      let file = newPseudoFile(size=parseInt args[0])
      files[cwd / args[1]] = file

when not defined(second):
  var sum = 0

  discard computeSize "/"
  for path, dirSize in dirSizes:
    if dirSize < 100_000:
      sum += dirSize

  echo fmt"Answer: {sum}"  
else:
  import
    std/algorithm,
    std/sequtils

  const maxFsSize = 70_000_000
  const updateSize = 30_000_000

  let currFsSize = computeSize "/"
  let requiredSize = currFsSize - (maxFsSize - updateSize)
  when not defined(release):
    echo fmt"{requiredSize = }"

  let dirSizesSeq = sorted toSeq dirSizes.values()
  for size in dirSizesSeq:
    if size > requiredSize:
      echo fmt"Answer: {size}"
      break
