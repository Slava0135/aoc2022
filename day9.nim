import std/[strutils, sets]

var visited: HashSet[(int16, int16)]
var head: (int16, int16)
var tail: (int16, int16)

visited.incl tail

for line in lines "input/9.txt":
  if line.len == 0:
    break
  let fragments = line.splitWhitespace()
  let dir = fragments[0]
  let steps = fragments[1].parseInt()
  for i in 1..steps:
    let oldHead = head
    case dir:
    of "U":
      head[1] += 1 
    of "R":
      head[0] += 1
    of "D":
      head[1] -= 1
    of "L":
      head[0] -= 1
    if abs(head[0] - tail[0]) > 1 or abs(head[1] - tail[1]) > 1:
      tail = oldHead
      visited.incl tail
echo visited.card
