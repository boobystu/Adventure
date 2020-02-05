require "collision"

rectangleHeight = 56
rectangleWidth = 56
doorAXCoord = 281
doorBXCoord = 393
doorCXCoord = 505
doorEntranceXCoord = 393

function BuildRoomWalls()

  BuildHorizontalRoomWalls()
  BuildVerticalRoomWalls()

end

function BuildCorridorWalls()

  for i = 1, love.graphics.getHeight(), rectangleHeight do

    local rectangle = {}
    InitialiseRectangle(rectangle, playingAreaMaxX * 2/5, i)

    table.insert(corridorWalls, rectangle)

    local rectangle = {}
    InitialiseRectangle(rectangle, playingAreaMaxX * 3/5, i)

    table.insert(corridorWalls, rectangle)

  end

end

function BuildHorizontalRoomWalls()

  for i = 1, playingAreaMaxX, rectangleWidth do

    local rectangle = {}
    InitialiseRectangle(rectangle, i, 0)

    if (i ~= doorAXCoord and i ~= doorBXCoord and i ~= doorCXCoord) then

      table.insert(roomWalls, rectangle)

    else

      if i == doorAXCoord then
        doorOptionA = rectangle
      elseif i == doorBXCoord then
        doorOptionB = rectangle
      else
        doorOptionC = rectangle
      end
    end

    local rectangle = {}
    InitialiseRectangle(rectangle, i, (love.graphics.getHeight() - rectangleHeight))

    if (i ~= doorEntranceXCoord) then
      table.insert(roomWalls, rectangle)
    end

  end

end

function BuildVerticalRoomWalls()

  for i = 1, love.graphics.getHeight(), rectangleHeight do

    local rectangle = {}
    InitialiseRectangle(rectangle, 0, i)

    table.insert(roomWalls, rectangle)

    local rectangle = {}
    InitialiseRectangle(rectangle, playingAreaMaxX, i)

    table.insert(roomWalls, rectangle)

  end

end

function InitialiseRectangle(rect, x, y)
  rect.width = rectangleWidth
  rect.height = rectangleHeight
  rect.xPosition = x
  rect.yPosition = y
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

  local doorOption = "A"
  if CheckForContactWithDoor(doorOption) == true then
    return
  end

  doorOption = "B"
  if CheckForContactWithDoor(doorOption) == true then
    return
  end

  doorOption = "C"
  if CheckForContactWithDoor(doorOption) == true then
    return
  end

end

function CheckForContactWithDoor(doorOption)

  local door = {}

  if doorOption == "A" then
    door = doorOptionA
  elseif doorOption == "B" then
    door = doorOptionB
  else
    door = doorOptionC
  end

  if CollisionDetected(player.x, player.y, player.w, player.h, door.xPosition, door.yPosition, door.width, door.height) then
    player.lastDoorWalkedThrough = doorOption
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
