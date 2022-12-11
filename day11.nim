import std/[strutils, strscans, sequtils, algorithm]

type
  Monkey = ref object
    id: int
    items: seq[int]
    operation: proc(level: int): int
    divider: int
    ifTrue, ifFalse: int

proc parseMonkey(rawMonkey: string): Monkey =
  result = new Monkey
  let lines = rawMonkey.splitLines()
  discard scanf(lines[0], "Monkey $i:", result.id)
  var list: string
  discard scanf(lines[1], "  Starting items: $*", list)
  result.items = list.split(", ").mapIt(it.parseInt())
  var op = '*'
  var num: int
  if scanf(lines[2], "  Operation: new = old $c $i", op, num):
    result.operation = proc(level: int): int =
      let op = op
      let num = num
      if op == '+':
        return level + num
      else:
        return level * num
  else:
    result.operation = proc(level: int): int =
      let op = op
      if op == '+':
        return level + level
      else:
        return level * level
  discard scanf(lines[3], "  Test: divisible by $i", result.divider)
  discard scanf(lines[4], "    If true: throw to monkey $i", result.ifTrue)
  discard scanf(lines[5], "    If false: throw to monkey $i", result.ifFalse)

proc partOne(rawMonkeys: openArray[string]): int =
  var monkeys = rawMonkeys.mapIt(parseMonkey(it))
  var inspections = newSeq[int](monkeys.len)
  for round in 1..20:
    for i in 0..high(monkeys):
      var monkey = monkeys[i]
      inspections[monkey.id] += monkey.items.len
      while monkey.items.len > 0:
        let item = monkey.items.pop()
        var level = monkey.operation(item)
        level = level div 3
        if level mod monkey.divider == 0:
          monkeys[monkey.ifTrue].items.add(level)
        else:
          monkeys[monkey.ifFalse].items.add(level)
  inspections.sort(Descending)
  return inspections[0] * inspections[1]

echo partOne(readFile("input/11_test.txt").split("\n\n"))
echo partOne(readFile("input/11.txt").split("\n\n"))
