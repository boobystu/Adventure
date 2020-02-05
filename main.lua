require "Highscore"
require "TextOperations"
require "collision"
require "GraphicsFunctions"
require "Player"
require "Walls"

highScores = {}
fonts = {}
player = {}
room = {}
walls = {}
doors = {}
titleColour = {}
titleColour.red = 0.01
titleColour.green = 0.33
titleColour.blue = 0.66

gameState = ""

function love.load(arg)

  LoadFont()

  LoadHighScores()

  BuildWalls()

  SetupPlayer()

  gameState = "StartScreen"

end

function love.update(dt)

  if gameState == "InGame" then
    UpdatePlayer()
  end

end

function love.draw()

  if gameState == "StartScreen" then
    DisplayStartScreen()
  elseif gameState == "InGame" then
    DisplayGame()
  end

end
