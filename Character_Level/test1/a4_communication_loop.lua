stringx = require('pl.stringx')
require 'io'

-- changing this to use the ptb vocab map
function readline()
  local line = io.read("*line")
  if line == nil then error({code="EOF"}) end
  line = stringx.split(line)
  if tonumber(line[1]) == nil then error({code="init"}) end
  for i = 2,#line do
    if not(ptb.vocab_map[line[i]]) then 
      error({code="vocab", word = line[i]}) 
    end
  end
  return line
end

function get_input()
  while true do 
    print("Query: len word1 word2 etc")
    local ok, line = pcall(readline)
    if not ok then
      if line.code == "EOF" then
        break -- end loop
      elseif line.code == "vocab" then
        print("Word not in vocabulary: ", line.word)
      elseif line.code == "init" then
        print("Start with a number")
      else
        print(line)
        print("Failed, try again")
      end
    else
      return line
    end
  end
end
