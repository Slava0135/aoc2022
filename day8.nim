import std/[sequtils, strutils, algorithm]

var trees: seq[seq[int]]

for line in lines "input/8.txt":
  trees.add line.mapIt parseInt $it

var visible: seq[seq[bool]]
for row in trees:
  visible.add(newSeqWith(row.len(), false))

proc getTreeAndMakeVisible(row, col: int): int = 
  visible[row][col] = true
  return trees[row][col]

for row in 0..high(trees):
  var highest = getTreeAndMakeVisible(row, 0)
  for col in 0..high(trees[row]):
    if trees[row][col] > highest:
      highest = getTreeAndMakeVisible(row, col)

for row in 0..high(trees):
  var highest = getTreeAndMakeVisible(row, trees[row].high)
  for col in countdown(high(trees[row]), 0):
    if trees[row][col] > highest:
      highest = getTreeAndMakeVisible(row, col)

for col in 0..high(trees[0]):
  var highest = getTreeAndMakeVisible(0, col)
  for row in 0..high(trees):
    if trees[row][col] > highest:
      highest = getTreeAndMakeVisible(row, col)

for col in 0..high(trees[0]):
  var highest = getTreeAndMakeVisible(trees.high, col)
  for row in countdown(high(trees), 0):
    if trees[row][col] > highest:
      highest = getTreeAndMakeVisible(row, col)

var total = 0
for row in visible:
  for elem in row:
    if elem:
      total += 1
      
echo total

var best_score = 0
for y in 0..trees.high:
  for x in 0..trees[y].high:
    let height = trees[y][x]
    var score = 1

    var count = 0

    for y in y+1..high(trees):
      count += 1
      if trees[y][x] >= height:
        break
    score *= count

    count = 0
    for y in countdown(y-1, 0):
      count += 1
      if trees[y][x] >= height:
        break
    score *= count

    count = 0
    for x in x+1..high(trees[y]):
      count += 1
      if trees[y][x] >= height:
        break
    score *= count

    count = 0
    for x in countdown(x-1, 0):
      count += 1
      if trees[y][x] >= height:
        break
    score *= count

    best_score = max(score, best_score)

echo best_score
