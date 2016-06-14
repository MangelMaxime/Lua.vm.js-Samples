window = js.global
document = window.document

local counter = 0

local ui = {
  button_substract = document:querySelector('.substract'),
  button_reset = document:querySelector('.reset'),
  button_add = document:querySelector('.add'),
  result = document:querySelector('.result')
}

function updateUI ()
  ui.result.textContent = counter
end

function increment ()
  counter = counter + 1
  updateUI()
end

function reset ()
  counter = 0
  updateUI()
end

function decrement ()
  counter = counter - 1
  updateUI()
end

function init ()
  updateUI()
  ui.button_substract:addEventListener('click', decrement)
  ui.button_reset:addEventListener('click', reset)
  ui.button_add:addEventListener('click', increment)
end
