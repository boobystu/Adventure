function DisplayScrollOrTreasure()

  if player.pickedUpQuestion == true then
    return
  end

  pickup.x = playingAreaMaxX * 0.5
  pickup.y = love.graphics.getHeight() * 0.5
  pickup.w = 38
  pickup.h = 50
  pickup.image = images.coin

  if item == "scroll" then
    pickup.image = images.scrollClosed
  end

  love.graphics.draw(pickup.image, pickup.x, pickup.y)

end


function ContactWithScrollOrTreasure()

  if pickup.w ~= 38 then
    return
  end

  if CollisionDetected(player.x, player.y, player.w, player.h, pickup.x, pickup.y, pickup.w, pickup.h) then
    player.pickedUpQuestion = true
    player.lastQuestionCorrect = false
    PopulateQuestionAndAnswers()
  end
end
