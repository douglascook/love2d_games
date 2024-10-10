-- Thanks Sheepolution! https://www.sheepolution.com/learn/book/contents
local theRectangles = {}
local fruits = {}

function love.load()
  Tick = require 'tick'
  Rectangle = require 'rectangle'

  fruits = {"melon", "orange", "lychee"}
  table.insert(fruits, "passion fruit")
  -- Removing item from a table shifts all following members up one
  table.remove(fruits, 1)

  -- how to unpack this into width and height of window? below doesn't work
  -- height, width = table.unpack(love.graphics.getDimensions())
  --
  ShowCircle = false
  Tick.recur(function() ShowCircle = not ShowCircle end, 1)
end

function love.keypressed(key)
  if key == 'space' then
    local rect = Rectangle.RandomRectangle()
    table.insert(theRectangles, rect)
  end
end

function love.update(dt)
  Tick.update(dt)

  for _,rect in ipairs(theRectangles) do
    -- REMEMBER need to call methods with : so that self is passed
    rect:update(dt)
  end
end

function love.draw()
  if ShowCircle then
    love.graphics.circle('line', 400, 300, 200)
  end

  for _,rect in ipairs(theRectangles) do
    rect:draw()
  end

  -- for i=1,#fruits do
  for i,f in ipairs(fruits) do
    love.graphics.print(f, 100, i*100)
  end
end
