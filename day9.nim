import std/[strutils, sets]

proc partOne(lines: openArray[string]): int =
  var visited: HashSet[(int16, int16)]
  var head: (int16, int16)
  var tail: (int16, int16)

  visited.incl tail

  for line in lines:
    if line.len == 0:
      break
    let fragments = line.splitWhitespace()
    let dir = fragments[0]
    let steps = fragments[1].parseInt()
    for i in 1..steps:
      let oldHead = head
      case dir:
      of "U": head[1] += 1 
      of "R": head[0] += 1
      of "D": head[1] -= 1
      of "L": head[0] -= 1
      if abs(head[0] - tail[0]) > 1 or abs(head[1] - tail[1]) > 1:
        tail = oldHead
        visited.incl tail
  return visited.card

proc printGrid(segm: openArray[(int16, int16)]) =
  const s = 6
  var grid: array[-s..s, array[-s..s, char]]
  for y in -s..s:
    for x in -s..s:
      grid[y][x] = '.'
  grid[0][0] = 's'
  for i in 0..high(segm):
    grid[-segm[i][1]][segm[i][0]] = i.intToStr()[0]
  for row in grid:
    echo row.join()
  echo "" 

proc partTwo(lines: openArray[string]): int =
  var visited: HashSet[(int16, int16)]
  var segm: array[10, (int16, int16)]

  visited.incl segm[^1]

  for line in lines:
    if line.len == 0:
      break
    let fragments = line.splitWhitespace()
    let dir = fragments[0]
    let steps = fragments[1].parseInt()
    for step in 1..steps:
      case dir:
      of "U": segm[0][1] += 1 
      of "R": segm[0][0] += 1
      of "D": segm[0][1] -= 1
      of "L": segm[0][0] -= 1
      for i in 1..high(segm):
        let diff_0 = segm[i][0] - segm[i-1][0]
        let diff_1 = segm[i][1] - segm[i-1][1]
        if abs(diff_0) > 1 and abs(diff_1) > 1:
          if diff_0 > 0:
            segm[i][0] -= 1
          else:
            segm[i][0] += 1
          if diff_1 > 0:
            segm[i][1] -= 1
          else:
            segm[i][1] += 1
        elif abs(diff_0) > 1:
          segm[i][1] = segm[i-1][1]
          if diff_0 > 0:
            segm[i][0] -= 1
          else:
            segm[i][0] += 1
        elif abs(diff_1) > 1:
          segm[i][0] = segm[i-1][0]
          if diff_1 > 0:
            segm[i][1] -= 1
          else:
            segm[i][1] += 1
      visited.incl segm[^1] 
      # printGrid(segm)
  return visited.card

echo part_one(readFile("input/9_test1.txt").splitLines())
echo part_one(readFile("input/9.txt").splitLines())

echo part_two(readFile("input/9_test1.txt").splitLines())
echo part_two(readFile("input/9_test2.txt").splitLines())
echo part_two(readFile("input/9.txt").splitLines())
