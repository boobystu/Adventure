require "ScrollOrTreasure"
require "Walls"

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

selectedCharacter = 0

function DisplayOptionsScreen()
  DisplayCharacterOptions()
  DisplayNameArea()
end

function DisplayCharacterOptions()

  love.graphics.setFont(fonts.large)

  love.graphics.print("1", playingAreaMaxX * (1/3), 150)
  love.graphics.print("2", playingAreaMaxX * (2/3), 150)
  love.graphics.draw(images.playerGirlDown, playingAreaMaxX * (1/3), 200)
  love.graphics.draw(images.playerBoyDown, playingAreaMaxX * (2/3), 200)

  if selectedCharacter == 1 then
    love.graphics.circle("line", playingAreaMaxX * (1/3) + 3, 154, 10)
  elseif selectedCharacter == 2 then
    love.graphics.circle("line", playingAreaMaxX * (2/3) + 3, 154, 10)
  end

end

function DisplayNameArea()

  love.graphics.setFont(fonts.veryLarge)

  local nameLength = #playerName

  love.graphics.print(playerName, playingAreaMaxX * (3/8), 300)

  for i=1, 8, 1 do
    if nameLength > i - 1 then
      love.graphics.print(string.sub(playerName,i,i), playingAreaMaxX * ((i+1)/10), 380)
    end
    love.graphics.print("_", playingAreaMaxX * ((i+1)/10), 400)
  end

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
end

function DisplayStartScreen()

  DisplayTitle()

  DisplayHighScores(highScoreX, highScoreY)
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

  --love.graphics.setColor(0.35, 0.07,0.05, alphaMax)

  for i = 1, #roomWalls, 1 do

    local roomWall = roomWalls[i]

    --love.graphics.rectangle("fill", roomWall.xPosition, roomWall.yPosition, roomWall.width, roomWall.height)
    love.graphics.draw(wallImage, roomWall.xPosition, roomWall.yPosition)

  end

  love.graphics.setColor(1, 1, 1, alphaMax)
end

function DisplayCorridorWalls()

  --love.graphics.setColor(0.35, 0.07,0.05, alphaMax)

  --love.graphics.setColor(1, 1, 1, alphaMax)

  for i = 1, #corridorWalls, 1 do

    local corridorWall = corridorWalls[i]

    love.graphics.draw(wallImage, corridorWall.xPosition, corridorWall.yPosition)

  end

  --love.graphics.setColor(1, 1, 1, alphaMax)

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
  questionAreaMinX = playingAreaMaxX
  questionAreaMaxX = windowMaxX

  love.window.setMode(windowMaxX, windowMaxY)

end
