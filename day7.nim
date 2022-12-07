import std/[strutils, tables, sequtils, algorithm]

var dirs = {"": 0}.toTable()
var current_dir = @[""]
for line in lines "input/7.txt":
  if line.len == 0:
    break
  if line[0] == '$':
    let args = line.splitWhitespace()
    if args[1] == "cd":
      let dir = args[2]
      case dir:
      of "/":
        current_dir = @[""]
      of "..":
        discard current_dir.pop()
      else:
        current_dir.add(dir)
  else:
    try:
      let size = line.splitWhitespace()[0].parseInt()
      for i in 0..high(current_dir):
        let dir = current_dir[0 .. i].join("/")
        if dirs.hasKeyOrPut(dir, size):
          dirs[dir] += size
    except ValueError:
      discard
var sum = 0
for size in dirs.values:
  if size <= 100_000:
    sum += size
echo sum

let total = 70_000_000
let required = 30_000_000
let available = total - dirs[""]
let toDelete = required - available

let sizes = dirs.values().toSeq().sorted(Ascending)

for s in sizes:
  if s > toDelete:
    echo s
    break
