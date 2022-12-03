import std/strutils

proc priority(dup: char): int =
  if dup.isUpperAscii:
    27 + int(dup) - int('A')
  else:
    1 + int(dup) - int('a')

proc part_one(lines: openArray[string]): int =
  var ans = 0
  for line in lines:
    if line.len == 0:
      break
    let mid = line.len() div 2 
    var first = line[0 ..< mid]
    var second = line[mid .. ^1]
    var dup: char
    for ch in first:
      if ch in second:
        dup = ch
        break
    ans += priority(dup)
  return ans

proc part_two(lines: openArray[string]): int =
  var ans = 0
  var i = 0
  while i <= high(lines):
    if lines[i].len == 0:
      break
    var dup: char
    for ch in lines[i]:
      if ch in lines[i+1] and ch in lines[i+2]:
        dup = ch
        break
    ans += priority(dup)
    i += 3
  return ans

echo part_one(readFile("input/3_test.txt").splitLines)
echo part_one(readFile("input/3.txt").splitLines)

echo part_two(readFile("input/3_test.txt").splitLines)
echo part_two(readFile("input/3.txt").splitLines)