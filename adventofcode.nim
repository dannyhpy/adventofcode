import
  httpclient,
  os,
  strformat
  
proc getInput*(year, day: int): string =
  try:
    let input = readFile(getCurrentDir() / "input.txt")
    
    return input
  except IOError:
    echo "adventofcode> Missing input.txt. Downloading..."
    let session = os.getEnv("SESSION")
    if session == "":
      echo "adventofcode> Unable to download without the SESSION environment variable."
      quit 1

    let client = newHttpClient()
    client.headers = newHttpHeaders({ "Cookie": fmt"session={session}" })

    let input = client.getContent fmt"https://adventofcode.com/{year}/day/{day}/input"
    
    writeFile(getCurrentDir() / "input.txt", input)
    
    return input