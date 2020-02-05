function DisplayScrollOrTreasure()

  if player.pickedUpQuestion == true then
    return
  end

  pickup.x = playingAreaMaxX * 0.5
  pickup.y = love.graphics.getHeight() * 0.5
  pickup.w = 10
  pickup.h = 10

  if player.lastQuestionCorrect == true then
    love.graphics.setColor(1, 1, 0, alphaMax)
  else
    love.graphics.setColor(0, 1, 0, alphaMax)
  end

  love.graphics.rectangle("fill", pickup.x, pickup.y, pickup.w, pickup.h)

end

function ContactWithScrollOrTreasure()

  if pickup.w ~= 10 then
    return
  end

  if CollisionDetected(player.x, player.y, player.w, player.h, pickup.x, pickup.y, pickup.w, pickup.h) then
    player.pickedUpQuestion = true
    player.lastQuestionCorrect = false
    PopulateQuestionAndAnswers()
  end
end
