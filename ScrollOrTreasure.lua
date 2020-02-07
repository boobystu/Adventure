require "QuestionOperations"
require "Scrolls"

function DisplayScrollOrTreasure()

  if player.pickedUpQuestion == true then
    return
  end

  pickup.x = playingAreaMaxX * 0.5
  pickup.y = love.graphics.getHeight() * 0.5
  pickup.w = 38
  pickup.h = 50
  pickup.image = images.coin

  if pickupItem == "scroll" then
    pickup.image = images.scrollClosed
  end

  love.graphics.draw(pickup.image, pickup.x, pickup.y)

end

function ContactWithEndScreenScrolls()

  if gameState ~= "EndScreen" then
    return
  end

  if #scrolls == 0 then
    return
  end

  for i = 1, #scrolls, 1 do
    if CollisionDetected(player.x, player.y, player.w, player.h, scrolls[i].endScreenXCoord, scrolls[i].endScreenYCoord, scrollWidth, scrollHeight) then
      scrolls[i].read = true
      linkAvailable = true
      url = scrolls[i].url
      return
    else
      linkAvailable = false
      url = ""
    end
  end

end

function ContactWithScrollOrTreasure()

  if pickup.w ~= 38 then
    return
  end

  if CollisionDetected(player.x, player.y, player.w, player.h, pickup.x, pickup.y, pickup.w, pickup.h) then
    PlayPickupSound()
    if player.pickedUpQuestion == false then
      if player.lastQuestionCorrect == true then
        AddToScore()
      else
        AddToScrolls()
      end
      RemoveLastQuestion()
    end
    player.pickedUpQuestion = true
    player.lastQuestionCorrect = false
    PopulateQuestionAndAnswers()
  end
end
