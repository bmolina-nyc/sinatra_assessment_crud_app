require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController 

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/users/login' do 
    erb :'users/login'
  end

  get '/users/index' do 
    if current_user 
      @user = current_user
      erb :'users/index'
    else
      flash[:message] = "You must be logged in!"
      redirect to '/users/login'
    end
  end

  post '/signup' do 
    if params.values.any? {|el| el.empty?}
      flash[:message] = "You need to enter all fields to signup!"
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      @user.save 
      session[:id] = @user.id
      redirect to '/users/index'
    end
  end

  post '/users/login' do 
    @user = User.find_by(username: params[:username])
  
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/users/index'
    else @user.nil?
      flash[:message] = "Login information incorrect"
      redirect '/users/login'
    end
  end

  get '/logout' do
    session.clear
    flash[:message] = "You have been logged out!"
    redirect to '/users/login'
  end




end