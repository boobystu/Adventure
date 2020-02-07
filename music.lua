
menuMusic = love.audio.newSource( "assets/sounds/menuMusic.ogg", "static" )
gameMusic = love.audio.newSource( "assets/sounds/gameMusic.ogg", "static" )
pickupSound = love.audio.newSource( "assets/sounds/pickup.mp3", "static" )

function PlayMenuMusic()
  StopAllMusic()
  menuMusic:setLooping( true )
  menuMusic:play()
end

function PlayGameMusic()
  StopAllMusic()
  gameMusic:setLooping( true )
  gameMusic:play()
end

function PlayPickupSound()
  pickupSound:play()
end

function StopAllMusic()
  menuMusic:stop()
  gameMusic:stop()
end
