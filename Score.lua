
local defaultTreasureValue = 100 -- tbc

local currentScore = 0
local currentTreasureValue = defaultTreasureValue

function GetScore ()
  return currentScore
end

function ResetScore()
  currentScore = 0
end

function AddToScore()
  if gameState == "InGame" then
    currentScore = currentScore + currentTreasureValue
  end
end

function ResetTreasureValue ()
  currentTreasureValue = defaultTreasureValue
end

function GetTreasureValue()
  return currentTreasureValue
end

function SetTreasureValue(value)
  currentTreasureValue = value
end

function GetDefaultTreasureValue()
  return defaultTreasureValue
end

function RenderScore()
  -- To be implemented if required.
end
