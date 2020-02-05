require "collision"

rectangleHeight = 56
rectangleWidth = 56

optionADoorLeft = 0.2
optionADoorRight = 0.25
optionBDoorLeft = .45
optionBDoorRight = .55
optionCDoorLeft = 0.75
optionCDoorRight = 0.8
entranceDoorLeft = 0.45
entranceDoorRight = 0.55

function BuildRoomWalls()

  BuildHorizontalRoomWalls()
  BuildVerticalRoomWalls()

end

function BuildCorridorWalls()

  for i = 1, love.graphics.getHeight(), rectangleHeight do

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = love.graphics.getWidth() * 2/5
    rectangle.yPosition = i

    table.insert(corridorWalls, rectangle)

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = love.graphics.getWidth() * 3/5
    rectangle.yPosition = i

    table.insert(corridorWalls, rectangle)

  end

end

function BuildHorizontalRoomWalls()

  for i = 1, love.graphics.getWidth(), rectangleWidth do

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = i
    rectangle.yPosition = 0

    if (i < love.graphics.getWidth() * optionBDoorLeft or
        i > love.graphics.getWidth() * optionBDoorRight) and
       (i < love.graphics.getWidth() * optionADoorLeft or
        i > love.graphics.getWidth() * optionADoorRight) and
       (i < love.graphics.getWidth() * optionCDoorLeft or
        i > love.graphics.getWidth() * optionCDoorRight) then

      table.insert(roomWalls, rectangle)
    else

      if doorOptionA.xPosition == -1 then
        doorOptionA = rectangle
      elseif doorOptionB.xPosition == -1 then
        doorOptionB = rectangle
      else
        doorOptionC = rectangle
      end
    end

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = i
    rectangle.yPosition = (love.graphics.getHeight() - rectangleHeight)

    if i < love.graphics.getWidth() * entranceDoorLeft or
       i > love.graphics.getWidth() * entranceDoorRight then
      table.insert(roomWalls, rectangle)
    end

  end

end

function BuildVerticalRoomWalls()

  for i = 1, love.graphics.getHeight(), rectangleHeight do

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = 0
    rectangle.yPosition = i

    table.insert(roomWalls, rectangle)

    local rectangle = {}
    rectangle.width = 56
    rectangle.height = 56
    rectangle.xPosition = (love.graphics.getWidth() - rectangleWidth)
    rectangle.yPosition = i

    table.insert(roomWalls, rectangle)

  end

end

function ContactWithWall()

  local walls = {}

  if player.location == "room" then
    walls = roomWalls
  else
    walls = corridorWalls
  end

  for i = 1, #walls, 1 do

    local wall = walls[i]

    if CollisionDetected(player.x, player.y, player.w, player.h, wall.xPosition, wall.yPosition, wall.width, wall.height) then
      return true
    end

  end

  return false

end

function CheckForContactWithDoors()

  if CheckForContactWithDoor("A") == true then
    return
  end

  if CheckForContactWithDoor("B") == true then
    return
  end

  if CheckForContactWithDoor("C") == true then
    return
  end

end

function CheckForContactWithDoor(option)

  local door = {}

  if option == "A" then
    door = doorOptionA
  elseif option == "B" then
      door = doorOptionB
  else
    door = doorOptionA
  end
  
  if CollisionDetected(player.x, player.y, player.w, player.h, door.xPosition, door.yPosition, door.width, door.height) then
    player.lastDoorWalkedThrough = option
    return true
  end

  return false

end

function SetupDoorOptions()
  SetupDoorOption(doorOptionA)
  SetupDoorOption(doorOptionB)
  SetupDoorOption(doorOptionC)
end

function SetupDoorOption(doorOption)
  doorOption.xPosition = -1
  doorOption.yPosition = -1
  doorOption.width = -1
  doorOption.height = -1
end
