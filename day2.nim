import std/strutils

var points = 0
for line in lines "input/2.txt":
  let words = line.split(' ')
  let opp_shape = words[0]
  let your_shape = words[1]
  case your_shape:
    of "X":
      points += 1
      case opp_shape:
        of "A":
          points += 3
        of "C":
          points += 6 
    of "Y":
      points += 2
      case opp_shape:
        of "B":
          points += 3
        of "A":
          points += 6 
    of "Z":
      points += 3
      case opp_shape:
        of "C":
          points += 3
        of "B":
          points += 6 
echo points

points = 0
for line in lines "input/2.txt":
  let words = line.split(' ')
  let opp_shape = words[0]
  let outcome = words[1]
  case outcome:
    of "X":
      case opp_shape:
        of "A":
          points += 3
        of "B":
          points += 1
        of "C":
          points += 2
    of "Y":
      points += 3
      case opp_shape:
        of "A":
          points += 1
        of "B":
          points += 2
        of "C":
          points += 3
    of "Z":
      points += 6
      case opp_shape:
        of "A":
          points += 2
        of "B":
          points += 3
        of "C":
          points += 1
echo points