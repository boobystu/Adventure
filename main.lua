require "Highscore"
require "TextOperations"
require "collision"
require "GraphicsFunctions"
require "Player"
require "Walls"
require "QuestionOperations"
require "ScrollOrTreasure"
require "music"
require "Score"
require "Thief"

pickupItem = ""
highScores = {}
fonts = {}
player = {}
room = {}
roomWalls = {}
corridorWalls = {}
endWalls = {}
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
pickup = {}
images = {}
wallImages = {}

allQuestions = {}
currentGameplayQuestions = {}
numberOfQuestionsPerGame = 5
playerName = ""

scrolls = {}

gameState = ""

tempGameScreenCounter = 0

function love.load(arg)

  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]

  PlayMenuMusic()

  SetupWindow()

  LoadImages()

  SetupDoorOptions()

  LoadFont()

  LoadHighScores()

  BuildRoomWalls()

  BuildCorridorWalls()

  BuildEndWalls()

  SetupPlayer()

  ReadQuestionFile()

  allQuestions = RandomiseQuestionOrder(allQuestions)

  currentGameplayQuestions = GetFirstNQuestions(allQuestions, numberOfQuestionsPerGame)

  gameState = "StartScreen"

end

function love.update(dt)

  if gameState == "InGame" or gameState == "EndScreen" then
    UpdatePlayer()
  end

  PopulateQuestionAndAnswers()

end

function love.draw()

  if gameState == "StartScreen" then
    ResetScore()
    ResetThiefValue()
    DisplayStartScreen()
  elseif gameState == "OptionsScreen" then
    DisplayOptionsScreen()
  elseif gameState == "InGame" then
    DisplayGame()
  elseif gameState == "EndScreen" then
    DisplayEndScreen()
  end

end
