import
  httpclient,
  os,
  strformat
  
let session = os.getEnv("SESSION")
if session == "":
  echo "Missing SESSION environment variable."
  quit 1

proc getInput*(year, day: int): string =
  try:
    let input = readFile(getCurrentDir() / "input.txt")
    
    return input
  except IOError:
    let client = newHttpClient()
    client.headers = newHttpHeaders({ "Cookie": fmt"session={session}" })

    let input = client.getContent fmt"https://adventofcode.com/{year}/day/{day}/input"
    
    writeFile(getCurrentDir() / "input.txt", input)
    
    return input