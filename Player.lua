require "ScrollOrTreasure"

movementSpeed = 7

function EnvIsAlphaNum(sIn)
  return (string.match(sIn,"[^%w]") == nil)
end

function CheckForGameStart(key)

  if key == "1" then
    selectedCharacter = 1
  elseif key == "2" then
    selectedCharacter = 2
  elseif EnvIsAlphaNum(key) then
    if #playerName < 8 then
      playerName = playerName .. key
    end
  end

  if selectedCharacter == 0 then
    return
  end

  if joystick then
    if key == "start" then
      gameState = "InGame"
    end
  end

  if key == "return" then
    gameState = "InGame"
  end

  if gameState == "InGame" then
    PlayGameMusic()
  end
end

function CheckForOptionsScreen(key)

  if joystick then
    if key == "start" then
      gameState = "OptionsScreen"
    end
  end

  if key == "return" then
    gameState = "OptionsScreen"
  end

  if gameState == "OptionsScreen" then
    playerName = ""
  end

end

function love.keyreleased(key)
  if gameState == "StartScreen" then
    CheckForOptionsScreen(key)
  elseif gameState == "OptionsScreen" then
    CheckForGameStart(key)
  end

end

function love.gamepadreleased(joystick, button)
  if gameState == "StartScreen" then
    CheckForOptionsScreen(button)
  elseif gameState == "OptionsScreen" then
    CheckForGameStart(button)
  end
end

function SetupPlayer()

  player.x = 200
  player.y = 200
  player.h = 45
  player.w = 27
  player.pickedUpQuestion = true
  player.location = "room"
  player.lastQuestionCorrect = false
  player.lastDoorWalkedThrough = ""
  if selectedCharacter == 1 then
    player.imageDown = images.playerGirlDown
    player.imageUp = images.playerGirlUp
    player.imageLeft = images.playerGirlLeft
    player.imageRight = images.playerGirlRight
  else
    player.imageDown = images.playerBoyDown
    player.imageUp = images.playerBoyUp
    player.imageLeft = images.playerBoyLeft
    player.imageRight = images.playerBoyRight
  end
  player.image = player.imageDown

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

  local playerDirection = ""

  if not joystick then
    playerDirection = GetKeyboardInput()
  else
    playerDirection = GetJoypadInput()
  end

  if playerDirection == "up" then
    player.image = player.imageUp
    if player.y > 0 then
      player.y = player.y - movementSpeed
    else
      PlayerChangingScreen()
    end
  end

  if playerDirection == "down" then
    player.image = player.imageDown
    if player.y + player.h < love.graphics.getHeight() then
      player.y = player.y + movementSpeed
    end
  end

  if playerDirection == "left" then
    player.image = player.imageLeft
    if player.x > 0 then
      player.x = player.x - movementSpeed
    end

  end

  if playerDirection == "right" then
    player.image = player.imageRight
    if player.x + player.w < love.graphics.getWidth() then
      player.x = player.x + movementSpeed
    end
  end

  CheckForContactWithDoors()

  ContactWithScrollOrTreasure()

  ContactWithScrollOrTreasure()

  if ContactWithWall() == true then
    player.x = originalX
    player.y = originalY
  end
end

function GetJoypadInput()
  if joystick:isGamepadDown("dpleft") then
    return "left"
  elseif joystick:isGamepadDown("dpright") then
    return "right"
  elseif joystick:isGamepadDown("dpup") then
    return "up"
  elseif joystick:isGamepadDown("dpdown") then
    return "down"
  end
end

function GetKeyboardInput()
  if love.keyboard.isDown("up") then
    return "up"
  elseif love.keyboard.isDown("down") then
    return "down"
  elseif love.keyboard.isDown("left") then
    return "left"
  elseif love.keyboard.isDown("right") then
    return "right"
  end
end

function PlayerChangingScreen()

  if player.location == "corridor" and player.pickedUpQuestion == false then
    return
  end
  player.x = (doorEntranceXCoord + (rectangleWidth / 2)) - (player.w / 2)
  player.y = love.graphics.getHeight()

  SetWallImage()

  if player.location == "room" then
    player.location = "corridor"
    player.pickedUpQuestion = false
    if question.answerCorrectOption == player.lastDoorWalkedThrough then
      player.lastQuestionCorrect = true
    end
  else
    player.location = "room"
  end

end
