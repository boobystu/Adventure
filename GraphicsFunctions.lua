alphaMax = 1
redColourDirection = "up"
greenColourDirection = "up"
blueColourDirection = "up"


function DisplayGame()

  DisplayWalls()
  DisplayDoors()
  DisplayBackground()
  DisplayPlayer()

end

function DisplayStartScreen()

  DisplayTitle()

  DisplayHighScores(100, 100)

end

function DisplayTitle()

  love.graphics.setFont(fonts.zeldaTitle)

  love.graphics.setColor(titleColour.red, titleColour.green, titleColour.blue, alphaMax)

  love.graphics.print("The Trails of IRIS", 170, 60)

  love.graphics.setFont(fonts.zeldaInstructions)

  love.graphics.print("Insert Coin", 345, 170)

  AlterTitleColours()

  love.graphics.setColor(1,1,1,alphaMax)

  love.graphics.setFont(fonts.large)
end

function DisplayWalls()

  love.graphics.setColor(0.35, 0.07,0.05, alphaMax)

  for i = 1, #walls, 1 do

    local wall = walls[i]

    love.graphics.rectangle("fill", wall.xPosition, wall.yPosition, wall.width, wall.height)

  end

  love.graphics.setColor(1, 1, 1, alphaMax)

end

function DisplayDoors()
  --todo
end

function DisplayBackground()
  --todo
end

function DisplayPlayer()
  love.graphics.setColor(0.13,0.57,0.86,alphaMax)

  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)

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
