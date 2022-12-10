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
      cycle += 1
    else:
      let frags = line.splitWhitespace()
      let val = frags[1].parseInt()
      if (cycle + 20) mod 40 == 0:
        sum += x * cycle
      cycle += 1
      if (cycle + 20) mod 40 == 0:
        sum += x * cycle
      cycle += 1
      x += val
  return sum

proc partTwo(lines: openArray[string]): string =
  var cycle = 1
  var sprite_pos = 1
  var crt: array[6, string]
  for line in lines:
    if line.len == 0 or cycle > 240:
      break
    if cycle mod 40 - sprite_pos in -1..1:
      crt[(cycle-1) div 40].add "#"
    else:
      crt[(cycle-1) div 40].add "." 
    cycle += 1
    let frags = line.splitWhitespace()
    if frags[0] == "addx":
      let val = frags[1].parseInt()
      sprite_pos += val
      if cycle mod 40 - sprite_pos in -1..1:
        crt[(cycle-1) div 40].add "#"
      else:
        crt[(cycle-1) div 40].add "." 
      cycle += 1
  return crt.join("\n") 


echo partOne(readFile("input/10_test.txt").splitLines())
echo partOne(readFile("input/10.txt").splitLines())

echo partTwo(readFile("input/10_test.txt").splitLines())
echo ""
echo partTwo(readFile("input/10.txt").splitLines())
