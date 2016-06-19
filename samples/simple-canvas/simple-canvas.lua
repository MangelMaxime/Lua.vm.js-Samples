-- Examples converted from http://www.alsacreations.com/tuto/lire/1511-introduction-canvas.html
local window = js.global
local document = window.document

ui = {
  canvas = {
    element,
    context
  }
}

function init()
  local canvas = document:querySelector(".canvas")
  if canvas == nil or canvas == js.null then
    return
  end

  local context = canvas:getContext("2d")

  ui.canvas.element = canvas
  ui.canvas.context = context

  draw()
end

function draw()
  local ctx = ui.canvas.context;

  -- Let's draw a boat

  ctx:beginPath()
  ctx:moveTo(150,80)
  ctx:lineTo(300,230)
  ctx:lineTo(150,230)
  ctx:closePath()
  ctx.fillStyle = "lightblue"
  ctx:fill()

  ctx:beginPath()
  ctx:moveTo(50,250)
  ctx:lineTo(100,300)
  ctx:lineTo(250,300)
  ctx:lineTo(300,250)
  ctx.fillStyle = "peru"
  ctx.strokeStyle = "sienna"
  ctx.lineWidth = 5
  ctx:fill()
  ctx:stroke()

  ctx:beginPath()
  ctx:moveTo(140,50)
  ctx:lineTo(140,250)
  ctx.lineWidth = 10
  ctx:stroke()

end
