function LoadFont()

  fonts.large = love.graphics.newFont("assets/fonts/manaspc.ttf", 10)
  fonts.veryLarge = love.graphics.newFont("assets/fonts/manaspc.ttf", 40)
  fonts.zeldaTitle = love.graphics.newFont("assets/fonts/Triforce.ttf", 50)
  fonts.zeldaInstructions = love.graphics.newFont("assets/fonts/Triforce.ttf", 20)
  love.graphics.setFont(fonts.large)

end
