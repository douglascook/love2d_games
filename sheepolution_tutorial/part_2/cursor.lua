-- From chapter 16
local function makeFireball()
  local fireball = {}
  fireball.x = math.random(0, 800)
  fireball.y = math.random(0, 600)
  fireball.image = love.graphics.newImage("assets/fireball.png")
  fireball.offset_x = fireball.image:getWidth() / 2
  fireball.offset_y = fireball.image:getHeight() / 2
  fireball.angle = 0
  fireball.speed = 80
  return fireball
end

local function getEuclideanDistance(x1, y1, x2, y2)
  return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

local fireball = makeFireball()
local cursor = love.graphics.newImage("assets/trump_surprised.png")

local function updateFireball(dt)
  MouseX, MouseY = love.mouse.getPosition()

  local distance = getEuclideanDistance(fireball.x, fireball.y, MouseX, MouseY)

  if distance > 50 then
    local speed = fireball.speed * distance / 50
    local angle = math.atan2(MouseY - fireball.y, MouseX - fireball.x)
    fireball.angle = angle
    fireball.x = fireball.x + speed * dt * math.cos(angle)
    fireball.y = fireball.y + speed * dt * math.sin(angle)
  end
end

local function draw()
  love.graphics.draw(fireball.image, fireball.x, fireball.y,
    fireball.angle, 0.5, 0.5, fireball.offset_x, fireball.offset_y
  )

  local scale = 0.2
  love.graphics.draw(
    cursor,
    MouseX - scale * (cursor:getWidth() / 2),
    MouseY - scale * (cursor:getHeight() / 2),
    0, 0.2, 0.2
  )
end

return {
  updateFireball = updateFireball,
  draw = draw
}
