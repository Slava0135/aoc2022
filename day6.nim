import std/sequtils

proc start(n: int): int =
  var pos = 0
  var recent = '@'.repeat(n)
  for ch in readFile("input/6.txt"):
    recent[pos mod n] = ch
    if pos > n and recent.allIt(recent.count(it) == 1):
      return pos + 1
    pos += 1
  
echo start(4)
echo start(14)
