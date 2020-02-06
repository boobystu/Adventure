require "ScrollOrTreasure"
require "Walls"

redColourDirection = "up"
greenColourDirection = "up"
blueColourDirection = "up"

titleX = 170
titleY = 60
instructionX = 345
instructionY = 170
highScoreX = 150
highScoreY = 250
scoreX = 10
scoreY = 10

playingAreaMaxX = 0
windowMaxX = 0
windowMaxY = 0
questionAreaMinX = 0
questionAreaMaxX = 0

selectedCharacter = 0

function DisplayOptionsScreen()
  DisplayCharacterOptions()
  DisplayNameArea()
end

function DisplayEndScreen()

  love.graphics.setFont(fonts.zeldaTitle)

  love.graphics.print("Game Over", playingAreaMaxX * (1/3), 150)

  love .graphics.setFont(fonts.zeldaInstructions)

  love.graphics.print("Press start to play again", playingAreaMaxX * (1/3), 250)
  DisplayScore()
end

function DisplayCharacterOptions()

  love.graphics.setFont(fonts.larger)

  love.graphics.print("Select a character by pressing 1 or 2", playingAreaMaxX * (1/3) - 90, 100)

  love.graphics.print("1", playingAreaMaxX * (1/3), 150)
  love.graphics.print("2", playingAreaMaxX * (2/3), 150)
  love.graphics.draw(images.playerGirlDown, playingAreaMaxX * (1/3), 200)
  love.graphics.draw(images.playerBoyDown, playingAreaMaxX * (2/3), 200)

  if selectedCharacter == 1 then
    love.graphics.circle("line", playingAreaMaxX * (1/3) + 6, 156, 15)
  elseif selectedCharacter == 2 then
    love.graphics.circle("line", playingAreaMaxX * (2/3) + 6, 156, 15)
  end

end

function DisplayNameArea()

  love.graphics.setFont(fonts.larger)

  love.graphics.print("Enter your name to continue", playingAreaMaxX * (1/3) - 30, 310)

  love.graphics.setFont(fonts.veryLarge)

  local nameLength = #playerName

  for i=1, 8, 1 do
    if nameLength > i - 1 then
      love.graphics.print(string.sub(playerName,i,i), playingAreaMaxX * ((i+1)/10), 360)
    end
    love.graphics.print("_", playingAreaMaxX * ((i+1)/10), 380)
  end

  love.graphics.setFont(fonts.larger)

  love.graphics.print("Press return to start the game", playingAreaMaxX * (1/3) - 30, 480)

end

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
  DisplayScore()
  DisplayPlayer()

end

function LoadImages()

  images.playerGirlDown = love.graphics.newImage("assets/images/girlfront.png")
  images.playerGirlUp = love.graphics.newImage("assets/images/girlback.png")
  images.playerGirlLeft = love.graphics.newImage("assets/images/girlleft.png")
  images.playerGirlRight = love.graphics.newImage("assets/images/girlright.png")
  images.playerBoyDown = love.graphics.newImage("assets/images/boyfront.png")
  images.playerBoyUp = love.graphics.newImage("assets/images/boyback.png")
  images.playerBoyLeft = love.graphics.newImage("assets/images/boyleft.png")
  images.playerBoyRight = love.graphics.newImage("assets/images/boyright.png")
  images.coin = love.graphics.newImage("assets/images/coin.png")
  images.scrollOpen = love.graphics.newImage("assets/images/scrollopen.png")
  images.scrollClosed = love.graphics.newImage("assets/images/scrollclosed.png")

  table.insert(wallImages, love.graphics.newImage("assets/images/wallOne.png"))
  table.insert(wallImages, love.graphics.newImage("assets/images/wallTwo.png"))
  table.insert(wallImages, love.graphics.newImage("assets/images/wallThree.png"))
  table.insert(wallImages, love.graphics.newImage("assets/images/wallFour.png"))
  table.insert(wallImages, love.graphics.newImage("assets/images/wallFive.png"))



end

function DisplayQuestion()
  love.graphics.setFont(fonts.zeldaInstructions)
  local yOrigin = 64
  local xOrigin = questionAreaMinX + scoreX
  local textWrapLimit = windowMaxX - xOrigin - 24 -- the 24 is just for some padding
  love.graphics.printf(
    question.questionText.."\n\n"..
    "A: "..question.answerTextA.."\n\n"..
    "B: "..question.answerTextB.."\n\n"..
    "C: "..question.answerTextC.."\n\n",
    xOrigin,
    yOrigin,
    textWrapLimit,
    "left")
end

function DisplayStartScreen()

  DisplayTitle()

  DisplayHighScores(highScoreX, highScoreY)
end

function DisplayScore (args)
  love.graphics.setFont(fonts.zeldaInstructions)
  love.graphics.print(
    playerName .. "'s Treasure: " .. GetScore(),
    questionAreaMinX + scoreX,
    scoreY
  )
  love.graphics.print(
    "Scrolls Collected: " .. #scrolls,
    questionAreaMinX + scoreX + 250,
    scoreY
  )
end

function DisplayTitle()

  love.graphics.setFont(fonts.zeldaTitle)

  love.graphics.setColor(titleColour.red, titleColour.green, titleColour.blue, alphaMax)

  love.graphics.print("The Trials of IRIS", titleX, titleY)

  love.graphics.setFont(fonts.zeldaInstructions)

  love.graphics.print("Insert Coin", instructionX, instructionY)

  AlterTitleColours()

  love.graphics.setColor(1,1,1,alphaMax)

  love.graphics.setFont(fonts.large)
end

function DisplayRoomWalls()

  for i = 1, #roomWalls, 1 do

    local roomWall = roomWalls[i]

    love.graphics.draw(wallImage, roomWall.xPosition, roomWall.yPosition)

  end

  love.graphics.setColor(1, 1, 1, alphaMax)
end

function DisplayCorridorWalls()

  for i = 1, #corridorWalls, 1 do

    local corridorWall = corridorWalls[i]

    love.graphics.draw(wallImage, corridorWall.xPosition, corridorWall.yPosition)

  end

end

function DisplayDoors()
  --todo
end

function DisplayRoomBackground()

  love.graphics.setFont(fonts.floorMarkers)
  love.graphics.setColor(1, 1, 1, 0.3)

  love.graphics.print("A", doorAXCoord, 60)
  love.graphics.print("B", doorBXCoord, 60)
  love.graphics.print("C", doorCXCoord, 60)

  love.graphics.setColor(1, 1, 1, alphaMax)

end

function DisplayCorridorBackground()
  --todo
end

function DisplayPlayer()

  love.graphics.draw(player.image, player.x, player.y)

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
  questionAreaMinX = playingAreaMaxX + 64 -- Wall width
  questionAreaMaxX = windowMaxX

  love.window.setMode(windowMaxX, windowMaxY)

end
