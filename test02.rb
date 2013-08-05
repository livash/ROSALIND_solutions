def test(str, arr)
  return "incorrect string length" if str.length > 200
  
  str[arr[0]..arr[1]] + " " + str[arr[2]..arr[3]]
end
str = 't8LLOANjiSHp2ouqEQ1Xrf29YLEpmgbwfruP1TzjrUGXgFb07kb1gEondW13hcqPVM8ek7SParamesotritonwG7reWoqcv0iUalcinous6j0PB9Z0UQy3hoiOryPo6XEQ2iaOidy4nKkeHtSRXTgRTCapFTzBoiDJNVXnAwvg6MJj.'
arr = [71, 84, 98, 105]
puts test(str, arr)