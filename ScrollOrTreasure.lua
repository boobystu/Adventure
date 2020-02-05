function DisplayScrollOrTreasure(item)

  pickup = {}
  pickup.x = love.graphics.getWidth() * 0.5
  pickup.y = love.graphics.getHeight() * 0.5
  pickup.w = 10
  pickup.h = 10

  if item == "treasure" then
    love.graphics.setColor(1, 1, 0, alphaMax)
  else
    love.graphics.setColor(0, 1, 0, alphaMax)
  end

  love.graphics.rectangle("fill", pickup.x, pickup.y, pickup.w, pickup.h)

end
