import strutils
import algorithm

let parts = read_file("input/5.txt").split("\n\n")
let setup = parts[0].split_lines()
let actions = parts[1].split_lines()

var stacks: seq[seq[char]]

for i in 0..(setup[0].len div 4):
  stacks.add(@[])

for line in setup.reversed():
  if line.contains('['):
    for i in countup(1, line.len(), 4):
      if not line[i].is_space_ascii:
        stacks[i div 4].add(line[i])

var stacks_copy = stacks.deepCopy()

for line in actions:
  let parts = line.splitWhitespace()
  if parts.len == 0:
    break
  let amount = parts[1].parseUInt()
  let m_from = parts[3].parseUInt()
  let m_to = parts[5].parseUInt()
  for i in 1..amount:
    let item = stacks[m_from-1].pop()
    stacks[m_to-1].add(item)

var answer_part_1 = ""
for i in 0..high(stacks):
  answer_part_1.add stacks[i][^1]

echo answer_part_1

stacks = stacks_copy
for line in actions:
  let parts = line.splitWhitespace()
  if parts.len == 0:
    break
  let amount = parts[1].parseUInt()
  let m_from = parts[3].parseUInt()
  let m_to = parts[5].parseUInt()
  var pickup: seq[char]
  for i in 1..amount:
    pickup.add stacks[m_from-1].pop()
  stacks[m_to-1].add(pickup.reversed)

var answer_part_2 = ""
for i in 0..high(stacks):
  answer_part_2.add stacks[i][^1]

echo answer_part_2