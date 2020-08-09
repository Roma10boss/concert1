Use Sinatra to build the app -
 Use ActiveRecord for storing information in a database
 Include more than one model class - Using three model classes: User, Artist, and Concert
 Include at least one has_many relationship - Artist has_many Concerts, User has_many Concerts, through: Artist
 Include user accounts - User accounts live in the User class
 Ensure that users can't modify content created by other users - User, Artist, and Concert info is protected in ApplicationController
 Include user input validations - User input validations within ApplicationController, some protections added in the forms
 Display validation failures to user with error message - Required inputs display an error message if invalid
 Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
