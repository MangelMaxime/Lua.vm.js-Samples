local window = js.global
local document = window.document
local ui

function init()
  local form = document:querySelector(".to-validate")
  if notNullJs(form) then

    form:addEventListener("submit",validate,false)

    ui.formElement = form
  end
end

function isRequired(element)
  print("isRequired")
  return notNullJs(element.value)
end

function notNullJs(value)
  return value ~= js.null and value ~= nil
end

function validate(this, event)
  event:preventDefault()

  for keyFields, fields in pairs(ui.fields) do
    for keys, values in pairs(fields.rules) do
      print(fields.id)
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
