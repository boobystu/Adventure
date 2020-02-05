require "FileOperations"

highScoreFile = "\\\\STKFPS1\\Data\\Users\\StuartYoung\\highscores.txt"

numberOfHighScores = 0

function LoadHighScores()

  ReadHighScoreFile()

  OrderHighScores()
end

function AddHighScore(name, score)

  if FileExists(highScoreFile) == false then
    return
  end

  local file = io.open(highScoreFile, "a")

  file:write(name .. "," .. score .. "\n")

  file:close()
end

function ReadHighScoreFile()

  if FileExists(highScoreFile) == false then
    return
  end

  local file = io.open(highScoreFile, "r")

  for line in file:lines() do
    if line ~= "" then

      local nameAndScore = line:split(",")

      local entry = {}

      entry.name = nameAndScore[1]
      entry.score = nameAndScore[2]

      table.insert (highScores, entry)

      numberOfHighScores = numberOfHighScores + 1
    end
  end
  file:close()
end

function OrderHighScores()

  local reorderingNeeded = false

  if numberOfHighScores < 2 then
    return
  end

  for counter = 1, #highScores - 1, 1 do

    if tonumber(highScores[counter].score) < tonumber(highScores[counter + 1].score) then

      reorderingNeeded = true

      local swap = {}

      swap.name = highScores[counter].name
      swap.score = highScores[counter].score

      highScores[counter].name = highScores[counter + 1].name
      highScores[counter].score = highScores[counter + 1].score

      highScores[counter + 1].name = swap.name
      highScores[counter + 1].score = swap.score
    end
  end

  if reorderingNeeded == true then
    OrderHighScores()
  end
end

function string:split( inSplitPattern, outResults )
  if not outResults then
    outResults = { }
  end
  local theStart = 1
  local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  while theSplitStart do
    table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
    theStart = theSplitEnd + 1
    theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
  end
  table.insert( outResults, string.sub( self, theStart ) )
  return outResults
end

function DisplayHighScores(startXPosition, startYPosition)

  local positionY = startYPosition

  local incrementY = 25

  local maxRow = #highScores

  if maxRow > 10 then
    maxRow = 10
  end

  for counter = 1, maxRow, 1 do
    love.graphics.print(counter .. ". " ..
                      NamePlusDots(highScores[counter].name) ..
                      highScores[counter].score,
                      startXPosition,
                      positionY)
    positionY = positionY + incrementY
  end
end

function NamePlusDots(name)

  name = name .. "............................"

  name = string.sub(name,1,30)

  return name
end
