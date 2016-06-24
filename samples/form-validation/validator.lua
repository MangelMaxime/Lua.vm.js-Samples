--- @author Maxime Mangel (aka Shadaen)
local window = js.global
local document = window.document
local ui

--- Initialize the validator page.
function init()
  local form = document:querySelector(".to-validate")
  if notNullJs(form) then
    form:addEventListener("submit",validate,false)
    ui.formElement = form

    ui.fields.pseudo.element = document:getElementById("pseudo")

    for keyFields, field in pairs(ui.fields) do
      field.element = document:getElementById(field.id)
    end

  end
end

--- Check if the field has been filled by the user.
-- @param field Field table to check
-- @return Return true if the value is not empty and return a msg string if there an error
function isRequired(field)
  return notEmpty(field.element.value), string.format("Field %s should not be empty", field.alias)
end

--- Check if the value if not "null" from Javascript point of view.
-- @param value Value to check
-- @return Return true if the is not null or undefined
function notNullJs(value)
  return value ~= js.null and value ~= nil
end

--- Check if the value is not empty from Javascript point of view.
-- @param value Value to check
-- @return Return true if the value is not empty
function notEmpty(value)
  return value ~= "" and notNullJs(value)
end

--- Validate a form and update the display if needed.
-- @param this Context of the form to validate
-- @param event Event that as trigger a valdiation
-- @return True if the form is valid. False otherwise
function validate(this, event)
  event:preventDefault()
  event:stopPropagation()

  local res = true

  for keyFields, field in pairs(ui.fields) do
    -- Clean the errors message
    while notNullJs(field.errorElement) and notNullJs(field.errorElement.firstChild) do
      field.errorElement:removeChild(field.errorElement.firstChild)
    end

    for keys, values in pairs(field.rules) do
      local result, msg = values(field)
      res = res and result
      updateDisplay(field, result, msg)
    end
  end

  if res then
    window:alert("Everything is OK")
  end
end

function isEmail(field)
  local res = field.element.value:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")
  if res then
    return res
  else
    return res, string.format("Value : %s is not a valid email", field.element.value)
  end
end

function isEqual(field)
  local elt = ui.fields[field.equalTo]
  local res = field.element.value == elt.element.value
  if res then
    return res
  else
    return res, string.format("%s and %s doesn't match", field.alias, elt.alias)
  end
end

function updateDisplay(field, result, msg)
  -- Check if we have an errorNode available for the correct field
  if field.errorElement == nil then
    -- Try go get the node from the DOM
    local selector = string.format("ul.errors-display[data-validate=\"%s\"]", field.id)
    local node = document:querySelector(selector)
    -- If no node found in the DOM generate it otherwise memorize it
    if (node == js.null) then
      generateErrorNode(field)
    else
      field.errorElement = node
    end
  end

  if not result then
    addMessage(field, msg)
  end
end

function addMessage(field, msg)
  local node = document:createElement("li")
  node.textContent = msg

  field.errorElement:appendChild(node)
end

function generateErrorNode(field)
  -- Create a new ul node and errors-display class
  local node = document:createElement("ul")
  node.classList:add("errors-display")
  node:setAttribute("data-validate", field.id)
  -- Add the node to the dom
  field.element.parentNode.parentNode:appendChild(node)
  -- Save the node reference in ui table
  field.errorElement = node
end

ui = {
  formClass = "to-validate",
  formElement,
  fields = {
    pseudo = {
      id = "pseudo",
      alias = "Pseudo",
      rules = {
        isRequired
      },
      element,
      errorElement
    },
    email = {
      id = "email",
      alias = "Email",
      rules = {
        isRequired,
        isEmail
      },
      element,
      errorElement
    },
    password = {
      id = "password",
      alias = "Password",
      rules = {
        isRequired
      },
      element,
      errorElement
    },
    password_conf = {
      id = "password_conf",
      alias = "Password confirmation",
      equalTo = "password",
      rules = {
        isRequired,
        isEqual
      },
      element,
      errorElement
    }
  }
}
