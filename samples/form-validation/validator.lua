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
  return notEmpty(field.element.value), string.format("Field %s should not be empty", field.id)
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

function validate(this, event)
  event:preventDefault()

  for keyFields, field in pairs(ui.fields) do
    for keys, values in pairs(field.rules) do
      local result, msg = values(field)
      print(msg)
    end
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

ui = {
  formClass = "to-validate",
  formElement,
  fields = {
    pseudo = {
      id = "pseudo",
      rules = {
        isRequired
      },
      element
    },
    email = {
      id = "email",
      rules = {
        isRequired,
        isEmail
      },
      element
    },
    password = {
      id = "password",
      rules = {
        isRequired
      },
      element
    },
    password_conf = {
      id = "password_conf",
      rules = {
        isRequired
      },
      element
    }
  }
}

init()
