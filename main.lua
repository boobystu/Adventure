require "Highscore"
require "TextOperations"

highScores = {}
fonts = {}

--nameAdded = false

function love.load(arg)

  LoadFont()

  LoadHighScores()

end

function love.update(dt)

  --if nameAdded == false then
    --AddHighScore("newName", 44444)
    --nameAdded = true
  --end

end

function love.draw()

  PrintHighScores(100, 100)

end
