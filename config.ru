require './config/environment'


use Rack::MethodOverride
use UsersController
use ProductsController
use CategoriesController
run ApplicationController


