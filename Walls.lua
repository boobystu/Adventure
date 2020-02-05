require "collision"

function BuildWalls()

  love.graphics.setColor(1,1,1,255)

  BuildHorizontalWalls()
  BuildVerticalWalls()

end

function BuildHorizontalWalls()

  rectangleHeight = 56
  rectangleWidth = 56

  for i = 1, love.graphics.getWidth(), rectangleWidth do

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = i
    rectangle.yPosition = 0

    if i < love.graphics.getWidth() * .4 or
       i > love.graphics.getWidth() * .6 then
      table.insert(walls, rectangle)
    end

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = i
    rectangle.yPosition = (love.graphics.getHeight() - rectangleHeight)

    if i < love.graphics.getWidth() * .4 or
       i > love.graphics.getWidth() * .6 then
      table.insert(walls, rectangle)
    end

  end

end

function BuildVerticalWalls()

  for i = 1, love.graphics.getHeight(), rectangleHeight do

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = 0
    rectangle.yPosition = i

    if i < love.graphics.getHeight() * .4 or
       i > love.graphics.getHeight() * .6 then
      table.insert(walls, rectangle)
    end

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = (love.graphics.getWidth() - rectangleWidth)
    rectangle.yPosition = i

    if i < love.graphics.getHeight() * .4 or
       i > love.graphics.getHeight() * .6 then
      table.insert(walls, rectangle)
    end

  end

end

function ContactWithWall()

  for i = 1, #walls, 1 do

    local wall = walls[i]

    if CollisionDetected(player.x, player.y, player.w, player.h, wall.xPosition, wall.yPosition, wall.width, wall.height) then
      return true
    end

  end

  return false

end
