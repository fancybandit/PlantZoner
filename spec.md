# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
    - Self-explanatory: `rails new PlantZoner'

- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)
    - User has_many Gardens
    - Plant has_many Gardens
    - GrowingZone has_many Gardens

- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    - Garden belongs_to Owner, class_name: "User"
    - Garden belongs_to GrowingZone
    - Garden belongs_to Plant

- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    - User has_many Plants, through: Gardens
    - User has_many GrowingZones, through: Gardens
    - Plant has_many GrowingZones, through: Gardens
    - Plant has_many Owners, class_name: "User", through: Gardens
    - GrowingZone has_many Plants, through: Gardens
    - GrowingZone has_many Owners, class_name: "User", through: Gardens

- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    - User has_many Plants, through: Gardens
    - User has_many GrowingZones, through: Gardens
    - Plant has_many GrowingZones, through: Gardens
    - Plant has_many Owners, class_name: "User", through: Gardens
    - GrowingZone has_many Plants, through: Gardens
    - GrowingZone has_many Owners, class_name: "User", through: Gardens

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity): Garden name:string
    - Garden name:string

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    - User
    - Plant
    - GrowingZone
    - Garden

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
    - User.github_affiliated URL: /users/github_affiliated

- [x] Include signup
    - OmniAuth & Sessions

- [x] Include login
    - OmniAuth & Sessions

- [x] Include logout
    - OmniAuth & Sessions

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    - OmniAuth using GitHub's OAuth

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    - /users/fancybandit/gardens

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    - /users/fancybandit/gardens/new

- [x] Include form display of validation errors (form URL e.g. /recipes/new)
    - /users/fancybandit/gardens/new
    - /gardens/20/plants/new

Confirm:
- [x] The application is pretty DRY

- [x] Limited logic in controllers

- [x] Views use helper methods if appropriate

- [x] Views use partials if appropriate