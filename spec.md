Specifications for the Rails Assessment

Specs:

    [X] Using Ruby on Rails for the project
    [X] Include at least one has_many relationship  (x has_many y; e.g. User has_many Recipes)
            - Brand has_many Kombuchas
  
    [X] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
            - Kombucha belongs_to a Brand
  
    [X] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
            - User has_many Kombuchas though Reviews
            - Kombucha has_many Users though Reviews

    [X] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
            - User has_many Kombuchas though Reviews, Kombuchas has_many Users though Reviews

    [X] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
            - title -- reviews.title
            - rating -- reviews.rating
            - content -- reviews.content
  
    [X] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
        - User
        - Brand
        - Kombucha
        - Reviews


    [X] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
        - Kombucha.order_by_rating   URL: /kombuchas  
        - Brand.abc_name  URL: /brands

     [X] Include signup (how e.g. Devise)
        - take user form input and check that its valid, if it is, create and save the new user object then log the user in 
        - bcrypt gem 
        - has_secure_password
     

     [X] Include login (how e.g. Devise)
        - if user is in the db w/ correct password, and all validations pass, then set and save the users id to be the session id
        - bcrypt gem 
        - has_secure_password
        - .authenticate method in SessionsController#create
        - add methods in ApplicationController that check for authorization


     [X] Include logout (how e.g. Devise)
        - SessionsController#destroy - delete the session 


     [X] Include third party signup/login (how e.g. Devise/OmniAuth)
            - Github omniauth
            - Google omniauth
            - .env file, omniauth hash, methods in session controller and user model
  
    [X] Include nested resource show or index (URL e.g. users/2/recipes)
            - INDEX:  kombuchas/2/reviews

    [X] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
            - kombuchas/2/reviews/new

    [X] Include form display of validation errors (form URL e.g. /recipes/new)
            - /kombuchas/new
            - /reviews/new
            - /kombuchas/2/reviews/new
            - /signup
            - /login
  

Confirm:

    [X] The application is pretty DRY
    [X] Limited logic in controllers
    [X] Views use helper methods if appropriate
    [X] Views use partials if appropriate
