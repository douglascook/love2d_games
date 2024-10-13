function love.load()
  -- Why not put these at the top as locals?
  Object = require 'classic'
  Player = require 'player'
  Enemy = require 'enemy'
  Bullet = require 'bullet'

  WindowHeight = love.graphics.getHeight()
  WindowWidth = love.graphics.getWidth()

  player = Player()
  enemy = Enemy()
  Bullets = {}
end

local function collided(this, that)
  local thisLeft = this.x
  local thisRight = this.x + this.width
  local thisTop = this.y
  local thisBottom = this.y + this.height
  local thatLeft = that.x
  local thatRight = that.x + that.width
  local thatTop = that.y
  local thatBottom = that.y + that.height

  return thisRight >= thatLeft
      and thisLeft <= thatRight
      and thisTop <= thatBottom
      and thisBottom >= thatTop
end

function love.update(dt)
  player:update(dt)
  enemy:update(dt)

  for i, b in ipairs(Bullets) do
    b:update(dt)
    if collided(b, enemy) then
      enemy:handleCollision()
      table.remove(Bullets, i)
    elseif b:dead() then
      table.remove(Bullets, i)
    end
  end
end

function love.keypressed(key)
  player:keypressed(key)
end

function love.draw()
  player:draw()
  enemy:draw()

  for _, b in ipairs(Bullets) do
    b:draw()
  end
end
