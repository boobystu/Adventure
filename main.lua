require "Highscore"
require "TextOperations"
require "collision"
require "GraphicsFunctions"
require "Player"
require "Walls"
require "QuestionOperations"

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

questions = {}
questionText = ""
answerTextA = ""
answerTextB = ""
answerTextC = ""
answerCorrectText = ""
answerCorrectOption = ""

gameState = ""

function love.load(arg)

  LoadFont()

  LoadHighScores()

  BuildWalls()

  SetupPlayer()

  ReadQuestionFile()

  questions = RandomiseQuestionOrder(questions)

  gameState = "StartScreen"

end

function love.update(dt)

  if gameState == "InGame" then
    UpdatePlayer()
  end

  PopulateQuestionAndAnswers()

end

function love.draw()

  if gameState == "StartScreen" then
    DisplayStartScreen()
  elseif gameState == "InGame" then
    DisplayGame()
  end

end
