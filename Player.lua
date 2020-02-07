require "ScrollOrTreasure"

movementSpeed = 7
playerDirection = ""

function EnvIsAlphaNum(sIn)
  return (string.match(sIn,"[^%w]") == nil)
end

function CheckForGameStart(key)

  if key == "1" then
    selectedCharacter = 1
  elseif key == "2" then
    selectedCharacter = 2
  elseif #key == 1 and EnvIsAlphaNum(key) then
    if #playerName < 8 then
      playerName = playerName .. key
    end
  end

  if selectedCharacter == 0 or #playerName == 0 then
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
    SetupPlayerSprite()
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

  SetupPlayerSprite()

  ResetForNewGame()

end

function SetupPlayerSprite()
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

  if player.lastDoorWalkedThrough == "" then
    return
  end

  if player.lastDoorWalkedThrough == question.answerCorrectOption then
    player.lastQuestionCorrect = true
  end

end

function UpdatePlayer()

  originalX = player.x
  originalY = player.y

  GetMovementInput()

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

  ContactWithEndScreenScrolls()

  if ContactWithWall() == true then
    player.x = originalX
    player.y = originalY
  end

  if ContactWithKey() then
    gameState = "StartScreen"
  end
end

function ContactWithKey()
  if gameState ~= "EndScreen" then
    return false
  end

  if AllScrollsRead() == false then
    return false
  end

  if CollisionDetected(player.x, player.y, player.w, player.h, keyX, keyY, keyW, keyH) then
    return true
  end

  return false
end

function GetMovementInput()

  playerDirection = ""

  if joystick then

    if joystick:isGamepadDown("dpleft") then
      playerDirection = "left"
    elseif joystick:isGamepadDown("dpright") then
      playerDirection = "right"
    elseif joystick:isGamepadDown("dpup") then
      playerDirection = "up"
    elseif joystick:isGamepadDown("dpdown") then
      playerDirection = "down"
    end
  end

  if playerDirection ~= "" then
    return
  end

  if love.keyboard.isDown("up") then
    playerDirection = "up"
  elseif love.keyboard.isDown("down") then
    playerDirection = "down"
  elseif love.keyboard.isDown("left") then
    playerDirection = "left"
  elseif love.keyboard.isDown("right") then
    playerDirection = "right"
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
      pickupItem = "coin"
    else
      pickupItem = "scroll"
    end
  elseif tempGameScreenCounter < 2 then
    player.location = "room"
    tempGameScreenCounter = tempGameScreenCounter + 1
  else
    if gameState ~= "EndScreen" then
      AddHighScore(playerName, GetScore())
      LoadHighScores()
    end
    gameState = "EndScreen"
    ResetForNewGame()
  end

end

function ResetForNewGame()
  player.x = playingAreaMaxX / 2
  player.y = love.graphics.getHeight() - 100
  tempGameScreenCounter = 0
  player.location = "room"
  PlayMenuMusic()
  PopulateEndGameScrollLocations()
end
