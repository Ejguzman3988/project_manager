require './config/environment'

use Rack::MethodOverride


use TasksController
use NotificationsController
use SessionsController
use ProjectsController
use UsersController
run ApplicationController
