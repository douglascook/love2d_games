-- Thanks Sheepolution! https://www.sheepolution.com/learn/book/contents
require('helpers')

local Rectangles = {}
local Fruits = {}

function love.load()
  Fruits = {"melon", "orange", "lychee"}
  table.insert(Fruits, "passion fruit")
  -- Removing item from a table shifts all following members up one
  table.remove(Fruits, 1)

  -- how to unpack this into width and height of window? below doesn't work
  -- height, width = table.unpack(love.graphics.getDimensions())
end

function love.keypressed(key)
  if key == 'space' then
    local rect = CreateRectangle()
    table.insert(Rectangles, rect)
  end
end

function love.update(dt)
  for _,rect in ipairs(Rectangles) do
    -- Delta time is the time between screen updates. Multiply magnitude by delta time
    -- to ensure consistency across machines
    if love.keyboard.isDown('right') then
      rect.x = (rect.x + rect.speed * dt) % 800
    elseif love.keyboard.isDown('left') then
      rect.x = (rect.x - rect.speed * dt) % 800
    end

    if love.keyboard.isDown('up') then
      rect.y = (rect.y - rect.speed * dt) % 600
    elseif love.keyboard.isDown('down') then
      rect.y = (rect.y + rect.speed * dt) % 600
    end
  end
end

function love.draw()
  for _,rect in ipairs(Rectangles) do
    love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
  end

  -- for i=1,#Fruits do
  for i,f in ipairs(Fruits) do
    love.graphics.print(f, 100, i*100)
  end
end
