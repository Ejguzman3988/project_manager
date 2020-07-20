require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash # used to start the Flash notices - On Every Controller
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # Starts to track sessions
    set :session_secret, ENV['SINATRA_SECRET'] # Creates a sinatra Secret
  end

  # Welcome Page
  # TODO: Consider Changes on Welcome Page
  #   i.e. See snap shot of projects. Link to github. Description. Check out other welcome pages for reference

  # Loads welcome page
  get "/" do
    erb :welcome
  end

  # Helper functions that are created to be used in controller
  helpers do
    def current_user # Gets current logged in user -> user obj
      User.find_by_id(session[:user_id])
    end

    def logged_in? # Checks if user is logged in -> truthy whether logged in
      !!current_user
    end

    # TODO: Redundant?
    def find_user # Finds logged in user -> Sets @user variable to a User obj
      @user = User.find_by_id(session[:user_id])
    end

    # TODO: change to find_project_by_id
    def find_project(id) # Finds a project by id -> Project obj
      @project = Project.find_by_id(id)
    end

    def sanitize_params(params) # Sanitizes user inputs -> hash of sanitized params
      if params[:user][:project]
        input = params[:user]
      else
        input = params
      end

      input.each do |k,v|
        rescue input[k] # TODO: Check if this rescue causes other problems
          input[k].each do |k1,v1|
            input[k][k1] = Rack::Utils.escape_html(v1)
        end
      end
      input
    end
  end
end
