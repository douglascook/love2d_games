require 'classic'
Tiles = require 'tiles'

Monster = Object:extend()

function Monster:new(x, y)
  self.x = x
  self.y = y
  self.tile = Tiles.getRandomMonster()
  self.colour = { 0.5, 0.5, 0.1 }
end

return Monster
