local fibonacci = require 'fibonacci-module'
local window = js.global
local document = window.document

local ui = {
  input = document:querySelector('input'),
  button = document:querySelector('button'),
  result = document:querySelector('.result')
}

ui.button:addEventListener('click', function ()
  local result = fibonacci(tonumber(ui.input.value))
  ui.result.textContent = 'Result: '..result
end)
