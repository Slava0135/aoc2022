import std/strutils

proc partOne(lines: openArray[string]): int =
  var cycle = 1
  var x = 1
  var sum = 0
  for line in lines:
    if line.len == 0:
      break
    if line == "noop":
      if (cycle + 20) mod 40 == 0:
        sum += x * cycle
        echo x, " ", cycle
      cycle += 1
    else:
      let frags = line.splitWhitespace()
      let val = frags[1].parseInt()
      if (cycle + 20) mod 40 == 0:
        sum += x * cycle
        echo x, " ", cycle
      cycle += 1
      if (cycle + 20) mod 40 == 0:
        sum += x * cycle
        echo x, " ", cycle
      cycle += 1
      x += val
  return sum

echo part_one(readFile("input/10_test.txt").splitLines())
echo part_one(readFile("input/10.txt").splitLines())
