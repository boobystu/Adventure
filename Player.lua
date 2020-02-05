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
  player.pickedUpQuestion = true
  player.location = "room"
  player.lastQuestionCorrect = false
  player.lastDoorWalkedThrough = ""

end

function CheckPlayerAnswer()

  player.lastQuestionCorrect = false

  if lastDoorWalkedThrough == "" then
    return
  end

  if lastDoorWalkedThrough == question.correctAnswer then
    player.lastQuestionCorrect = true
  end

end

function UpdatePlayer()

  originalX = player.x
  originalY = player.y

  if love.keyboard.isDown("up") then
    if player.y > 0 then
      player.y = player.y - movementSpeed
    else
      PlayerChangingScreen()
    end
  end

  if love.keyboard.isDown("down") then
    if player.y + player.h < love.graphics.getHeight() then
      player.y = player.y + movementSpeed
    end
  end

  if love.keyboard.isDown("left") then
    if player.x > 0 then
      player.x = player.x - movementSpeed
    end

  end

  if love.keyboard.isDown("right") then
    if player.x + player.w < love.graphics.getWidth() then
      player.x = player.x + movementSpeed
    end
  end

  CheckForContactWithDoor()

  if ContactWithWall() == true then
    player.x = originalX
    player.y = originalY
  end
end

function PlayerChangingScreen()
  
  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight()

  if player.location == "room" then
    player.location = "corridor"
    player.pickedUpQuestion = false
  else
    player.location = "room"
  end

  GetNextQuestion()

end
