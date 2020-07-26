require './config/environment'

use Rack::MethodOverride

use NotificationsController
use SessionsController
use ProjectsController
use UsersController
run ApplicationController
