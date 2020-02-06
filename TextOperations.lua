function LoadFont()

  fonts.large = love.graphics.newFont("assets/fonts/manaspc.ttf", 10)
  fonts.larger = love.graphics.newFont("assets/fonts/manaspc.ttf", 20)
  fonts.veryLarge = love.graphics.newFont("assets/fonts/manaspc.ttf", 40)
  fonts.zeldaTitle = love.graphics.newFont("assets/fonts/Triforce.ttf", 50)
  fonts.zeldaInstructions = love.graphics.newFont("assets/fonts/Triforce.ttf", 20)
  fonts.floorMarkers = love.graphics.newFont("assets/fonts/minecraft.otf", 90)
  love.graphics.setFont(fonts.large)

end
