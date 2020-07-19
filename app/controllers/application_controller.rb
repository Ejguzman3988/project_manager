require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SINATRA_SECRET']
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def find_user
      @user = User.find_by_id(session[:user_id])
    end

    def find_project(id)
      @project = Project.find_by_id(id)
    end

    def sanitize_project_params(params)
      user_input = params[:user][:project]
      user_input.each do |k,v|
          params[:user][:project][k] = Rack::Utils.escape_html(v)
      end
    end

    def sanitize_params(params)
      unless logged_in?
        input = params
        input.each do |k,v|
          input[k].each do |k1,v1|
            params[k][k1] = Rack::Utils.escape_html(v1)
          end
        end
      else
        input = params[:user]
        input.each do |k,v|
          input[k].each do |k1,v1|
            params[:user][k][k1] = Rack::Utils.escape_html(v1)
          end
        end
      end
    end
  end
end
