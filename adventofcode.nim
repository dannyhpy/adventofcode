#[
  This file works by doing a lot of assumptions
  about the project folder structure.

  For instance, it assumes the executable
  directory to be something in a "YYYY/DD"
  format.

  It also assumes the session key to be
  available at the project root.
  (in other words "../../session.key")
]#

import
  std/httpclient,
  std/os,
  std/strformat,
  std/strutils

when isMainModule:
  stderr.writeLine "adventofcode> This can not be ran directly."
  quit 1

let sessionKeyPath = os.getAppDir() / ".." / ".." / "session.key"
if not fileExists sessionKeyPath:
  stderr.writeLine "adventofcode> secret.key could not be found."
let sessionKey = readFile sessionKeyPath
if sessionKey[0 ..< 10] == "\x00GITCRYPT\x00":
  stderr.writeLine "adventofcode> secret.key is encrypted."
  quit 1
  
proc getInput*(year, day: int): string =
  ## Automatically downloads the input from
  ## AdventOfCode, unless there is a local copy
  ## of the input as 'input.txt' in the app dir.
  let inputPath = os.getAppDir() / "input.txt"
  if fileExists inputPath:
    echo "adventofcode> Proceeding with current input.txt file."
    let input = readFile inputPath
    
    return input.strip(chars = {'\n'})
  else:
    echo "adventofcode> Missing input.txt. Downloading..."

    let client = newHttpClient()
    client.headers = newHttpHeaders({ "Cookie": fmt"session={sessionKey}" })

    let input = client.getContent fmt"https://adventofcode.com/{year}/day/{day}/input"
    
    writeFile(inputPath, input)
    
    return input.strip(chars = {'\n'})

proc getInput*(): string =
  ## Tries to determine year and date of
  ## day by looking at the app dir path.
  let day = block:
    let p = os.getAppDir().splitPath()
    p.tail.parseInt()
  let year = block:
    let p = os.getAppDir().parentDir().splitPath()
    p.tail.parseInt()
  result = getInput(year, day)
