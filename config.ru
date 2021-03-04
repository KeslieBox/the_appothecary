require './config/environment'


use Rack::MethodOverride
use UsersController
use HerbsController
use ProductsController
use TincturesController
run ApplicationController


