require "ScrollOrTreasure"

redColourDirection = "up"
greenColourDirection = "up"
blueColourDirection = "up"

titleX = 170
titleY = 60
instructionX = 345
instructionY = 170
highScoreX = 260
highScoreY = 300

playingAreaMaxX = 0
windowMaxX = 0
windowMaxY = 0
questionAreaMinX = 0
questionAreaMaxX = 0

function DisplayGame()

  if player.location == "room" then
    DisplayRoomWalls()
    DisplayRoomBackground()
    DisplayQuestion()
  else
    DisplayCorridorWalls()
    DisplayCorridorBackground()
    DisplayScrollOrTreasure()
  end
  DisplayPlayer()

end

function DisplayQuestion()
end

function DisplayStartScreen()

  DisplayTitle()

  DisplayHighScores(highScoreX, highScoreY)
end

function DisplayTitle()

  love.graphics.setFont(fonts.zeldaTitle)

  love.graphics.setColor(titleColour.red, titleColour.green, titleColour.blue, alphaMax)

  love.graphics.print("The Trails of IRIS", titleX, titleY)

  love.graphics.setFont(fonts.zeldaInstructions)

  love.graphics.print("Insert Coin", instructionX, instructionY)

  AlterTitleColours()

  love.graphics.setColor(1,1,1,alphaMax)

  love.graphics.setFont(fonts.large)
end

function DisplayRoomWalls()

  love.graphics.setColor(0.35, 0.07,0.05, alphaMax)

  for i = 1, #roomWalls, 1 do

    local roomWall = roomWalls[i]

    love.graphics.rectangle("fill", roomWall.xPosition, roomWall.yPosition, roomWall.width, roomWall.height)

  end

  love.graphics.setColor(1, 1, 1, alphaMax)
end

function DisplayCorridorWalls()

  love.graphics.setColor(0.35, 0.07,0.05, alphaMax)

  for i = 1, #corridorWalls, 1 do

    local corridorWall = corridorWalls[i]

    love.graphics.rectangle("fill", corridorWall.xPosition, corridorWall.yPosition, corridorWall.width, corridorWall.height)

  end

  love.graphics.setColor(1, 1, 1, alphaMax)
end

function DisplayDoors()
  --todo
end

function DisplayRoomBackground()
  --todo
end

function DisplayCorridorBackground()
  --todo
end

function DisplayPlayer()
  love.graphics.setColor(0.13,0.57,0.86,alphaMax)

  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

  --love.graphics.print("lastwalkedthrough = " .. player.lastDoorWalkedThrough, player.x, player.y)
  --love.graphics.print("CorrectQuestionOption = " .. CorrectQuestionOption(), player.x, player.y + 10)

  love.graphics.setColor(1,1,1,alphaMax)
end

function AlterTitleColours()

  if redColourDirection == "up" then
    titleColour.red = titleColour.red + 0.01
  elseif redColourDirection == "down" then
    titleColour.red = titleColour.red - 0.01
  end

  if greenColourDirection == "up" then
    titleColour.green = titleColour.green + 0.02
  elseif greenColourDirection == "down" then
    titleColour.green = titleColour.green - 0.02
  end

  if blueColourDirection == "up" then
    titleColour.blue = titleColour.blue + 0.03
  elseif blueColourDirection == "down" then
    titleColour.blue = titleColour.blue - 0.03
  end

  if titleColour.red >= 1 then
    redColourDirection = "down"
  elseif titleColour.red <= 0.1 then
    redColourDirection = "up"
  end

  if titleColour.green >= 1 then
    greenColourDirection = "down"
  elseif titleColour.green <= 0.1 then
    greenColourDirection = "up"
  end

  if titleColour.blue >= 1 then
    blueColourDirection = "down"
  elseif titleColour.blue <= 0.1 then
    blueColourDirection = "up"
  end
end

function SetupWindow()

  playingAreaMaxX = 785
  windowMaxX = 1400
  windowMaxY = 600
  questionAreaMinX = playingAreaMaxX
  questionAreaMaxX = windowMaxX

  love.window.setMode(windowMaxX, windowMaxY)

end
