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

debug = true
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
url = ""

allQuestions = {}
currentGameplayQuestions = {}
numberOfQuestionsPerGame = 5
playerName = ""

scrolls = {}
endGameScrollLocations = {}

gameState = ""

tempGameScreenCounter = 0
scrollWidth = 38
scrollHeight = 50

linkAvailable = false

keyX = 0
keyY = 100
keyW = 46
keyH = 42

function love.load(arg)

  love.window.setTitle("The Trials of IRIS")

  local joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]

  PlayMenuMusic()

  SetupWindow()

  LoadImages()

  SetupDoorOptions()

  LoadFont()

  BuildRoomWalls()

  BuildCorridorWalls()

  BuildEndWalls()

  LoadHighScores()

  SetupPlayer()

  ReadQuestionFile()

  PopulateEndGameScrollLocations()

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

function love.mousepressed(x, y, b, isTouch)
  if b ~= 1 then
    return
  end

  if linkAvailable == false then
    return
  end

  if url == "No URL available" then
    return
  end

  if x >= questionAreaMinX then
    love.system.openURL(url)
  end

end
