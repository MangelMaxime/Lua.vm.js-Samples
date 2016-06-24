# Lua.vm.js-Samples

## Form validation

*Summary*

The goal of this sample is to show how we can use a lua table to encapsulate all the
ui logic.

Extract :

```lua
local ui = {
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
```

This table contains a list of fields where all the logic of validation is.

Each field consist of:

-   `id` : id value to select the field via `document:getElementById(...)`
-   `alias` : value used to display the errors information
-   `rules` : list of rules to apply on the current field
-   `element` : reference to the DOM element
-   `errorElement` : reference to the DOM element used to display the errors

The fields can also have some extra keys like:

-   `equalTo` : used by the isEqual rule to know the field to compare
with the current one

[Go to sample](/samples/form-validation/)
