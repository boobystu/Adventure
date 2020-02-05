require "Score"

local defaultThiefValue = 10 -- tbc

local currentThiefValue = defaultThiefValue

function ResetThiefValue ()
  currentThiefValue = defaultThiefValue
end

function GetThiefValue ()
  return currentThiefValue
end

function SetThiefValue (value)
  currentThiefValue = value
end

function StealTreasure ()
  if currentTreasureValue > 0 then
    currentTreasureValue = currentTreasureValue - currentThiefValue
  end
end

function RenderTreasureValue ()
  -- To be implemented if required.
end
