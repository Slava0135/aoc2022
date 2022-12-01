import std/parseutils
import std/algorithm
import std/math

var max_cal = 0
var cur_cal = 0
for line in lines "input/1.txt":
  if len(line) == 0:
    max_cal = max(max_cal, cur_cal)
    cur_cal = 0
  else:
    var new_cal = 0
    discard parse_int(line, new_cal)
    cur_cal += new_cal
echo max_cal

var max_cals = [0, 0, 0]
cur_cal = 0
for line in lines "input/1.txt":
  if len(line) == 0:
    sort(max_cals)
    for i in low(max_cals)..high(max_cals):
      if max_cals[i] < cur_cal:
        max_cals[i] = cur_cal
        break
    cur_cal = 0
  else:
    var new_cal = 0
    discard parse_int(line, new_cal)
    cur_cal += new_cal
echo sum(max_cals)
