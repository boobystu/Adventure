require "Highscore"
require "TextOperations"
require "collision"
require "GraphicsFunctions"
require "Player"
require "Walls"
require "QuestionOperations"
require "Questions"
require "ScrollOrTreasure"
require "Score"
require "Thief"

highScores = {}
fonts = {}
player = {}
room = {}
roomWalls = {}
corridorWalls = {}
doors = {}
question = {}
titleColour = {}
titleColour.red = 0.01
titleColour.green = 0.33
titleColour.blue = 0.66
alphaMax = 1
doorOptionA = {}
doorOptionB = {}
doorOptionC = {}

allQuestions = {}
currentGameplayQuestions = {}
numberOfQuestionsPerGame = 5
questionText = ""
answerTextA = ""
answerTextB = ""
answerTextC = ""
answerCorrectText = ""
answerCorrectOption = ""

gameState = ""

function love.load(arg)

  SetupDoorOptions()

  LoadFont()

  LoadHighScores()

  BuildRoomWalls()

  BuildCorridorWalls()

  SetupPlayer()

  ReadQuestionFile()

  allQuestions = RandomiseQuestionOrder(allQuestions)

  currentGameplayQuestions = GetFirstNQuestions(allQuestions, numberOfQuestionsPerGame)

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
    ResetScore()
    ResetThiefValue()
    DisplayStartScreen()
  elseif gameState == "InGame" then
    DisplayGame()
  end

end
