require './config/environment'

use Rack::MethodOverride

use SessionsController
use ProjectsController
use UsersController
run ApplicationController
