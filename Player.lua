movementSpeed = 10

function CheckForGameStart(key)

  if key == "return" then
    gameState = "InGame"
  end

end

function love.keyreleased(key)
  if gameState == "StartScreen" then
    CheckForGameStart(key)
  end

end

function SetupPlayer()
  player.x = 200
  player.y = 200
  player.h = 10
  player.w = 10

end

function UpdatePlayer()

  originalX = player.x
  originalY = player.y

  if love.keyboard.isDown("up") then
    if player.y > 0 then
      player.y = player.y - movementSpeed
    else
      player.y = love.graphics.getHeight()
    end
  end

  if love.keyboard.isDown("down") then
    if player.y + player.h < love.graphics.getHeight() then
      player.y = player.y + movementSpeed
    else
      player.y = 0
    end
  end

  if love.keyboard.isDown("left") then
    if player.x > 0 then
      player.x = player.x - movementSpeed
    else
      player.x = love.graphics.getWidth()
    end

  end

  if love.keyboard.isDown("right") then
    if player.x + player.w < love.graphics.getWidth() then
      player.x = player.x + movementSpeed
    else
      player.x = 0
    end
  end

  if ContactWithWall() == true then
    player.x = originalX
    player.y = originalY
  end
end
