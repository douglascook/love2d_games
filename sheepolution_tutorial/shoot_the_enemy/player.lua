local Player = Object:extend()

function Player:new()
  self.image = love.graphics.newImage("assets/trex.png")
  self.scale = 0.6
  self.height = self.image:getHeight() * self.scale
  self.width = self.image:getWidth() * self.scale

  self.x = 10
  self.y = WindowHeight / 2

  self.speed = 400
end

function Player:update(dt)
  if love.keyboard.isDown("down") or love.keyboard.isDown("j") then
    self.y = self.y + self.speed * dt
  elseif love.keyboard.isDown("up") or love.keyboard.isDown("k") then
    self.y = self.y - self.speed * dt
  end

  if self.y < 0 then
    self.y = 0
  elseif self.y > WindowHeight - self.height then
    self.y = WindowHeight - self.height
  end
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end

function Player:keypressed(key)
  if key == 'space' then
    table.insert(Bullets, Bullet(self.x + self.width, self.y))
  end
end

return Player
