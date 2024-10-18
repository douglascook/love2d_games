-- From chapter 17
local jumping = love.graphics.newImage("assets/jump_with_border.png")

local function makeJumpFrames()
  local width = jumping:getWidth()
  local height = jumping:getHeight()
  local frame_width = 117
  local frame_height = 233

  local frames = {}
  local frame_count = 5
  for i = 0, 1 do
    for j = 0, 2 do
      -- Don't include blank frame
      if #frames >= frame_count then
        break
      end

      -- Quads are independent of the image, they are just generic sets of coords.
      local frame = love.graphics.newQuad(
      -- 1 pixel border around *every* frame. Initial offset of 1 for leftmost border,
      -- then 2 per frame for the double border between frames.
        1 + j * (frame_width + 2), 1 + i * (frame_height + 2),
        frame_width, frame_height, width, height
      )
      table.insert(frames, frame)
    end
  end

  return frames
end

local frames = makeJumpFrames()
local current_frame = 1

-- TODO how to parmaterise modules to control eg. jump speed from main?
local function updateFrame(dt)
  current_frame = current_frame + (15 * dt)
  if current_frame >= 6 then
    current_frame = current_frame - 5
  end
end

local function draw(x, y)
  love.graphics.draw(jumping, frames[math.floor(current_frame)], x, y)
end

-- Public interface
return {
  updateFrame = updateFrame,
  draw = draw
}
