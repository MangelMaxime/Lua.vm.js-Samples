local window = js.global
local document = window.document
local ui

function init()
  local form = document:querySelector(".to-validate")
  if notNullJs(form) then
    form:addEventListener("submit",validate,false)
    ui.formElement = form

    ui.fields.pseudo.element = document:getElementById("pseudo")

  end
end

function isRequired(element)
  return notEmpty(element.value), "Field should not be empty"
end

function notNullJs(value)
  return value ~= js.null and value ~= nil
end

function notEmpty(value)
  return value ~= "" and notNullJs(value)
end

function validate(this, event)
  event:preventDefault()

  for keyFields, field in pairs(ui.fields) do
    for keys, values in pairs(field.rules) do
      local result, msg = values(field.element)
      print(result)
      print(msg)
    end
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

      },
      element
    },
    password = {
      id = "password",
      rules = {

      },
      element
    },
    password_conf = {
      id = "password_conf",
      rules = {

      },
      element
    }
  }
}

init()
