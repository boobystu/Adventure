require "Highscore"
require "TextOperations"
require "collision"
require "GraphicsFunctions"
require "Player"
require "Walls"
require "QuestionOperations"
require "ScrollOrTreasure"

highScores = {}
fonts = {}
player = {}
room = {}
roomWalls = {}
corridorWalls = {}
doors = {}
questions = {}
question = {}
titleColour = {}
titleColour.red = 0.01
titleColour.green = 0.33
titleColour.blue = 0.66
alphaMax = 1
doorOptionA = {}
doorOptionB = {}
doorOptionC = {}
pickup = {}

questions = {}
questionText = ""
answerTextA = ""
answerTextB = ""
answerTextC = ""
answerCorrectText = ""
answerCorrectOption = ""

gameState = ""

function love.load(arg)

  SetupWindow()

  SetupDoorOptions()

  LoadFont()

  LoadHighScores()

  BuildRoomWalls()

  BuildCorridorWalls()

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
