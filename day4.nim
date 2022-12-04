import std/strutils

func solve(lines: openArray[string]): (int, int) =
  var full_overlaps = 0
  var overlaps = 0
  for line in lines:
    if line.len == 0:
      break
    let pairs = line.split(',')
    let first = pairs[0].split('-')
    let second = pairs[1].split('-')
    var first_sections: set[uint16]
    var second_sections: set[uint16]
    for i in first[0].parseUInt()..first[1].parseUInt():
      first_sections.incl i.uint16
    for i in second[0].parseUInt()..second[1].parseUInt():
      second_sections.incl i.uint16
    if first_sections <= second_sections or first_sections >= second_sections:
      full_overlaps += 1
    if (first_sections * second_sections).len != 0:
      overlaps += 1
  return (full_overlaps, overlaps)

echo solve(readFile("input/4_test.txt").splitLines)
echo solve(readFile("input/4.txt").splitLines)

