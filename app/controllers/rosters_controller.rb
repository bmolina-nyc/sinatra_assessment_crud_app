require './config/environment'
require 'rack-flash'

class RostersController < ApplicationController 
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # this is where a login gets routed - we want to see all rosters
  get '/rosters/index' do 
    if current_user
       @rosters = Roster.all
       @user = current_user
       erb :'/rosters/index' 
     else
       flash[:message] = "You must be logged in to see a roster page!"
       redirect to '/users/login'
     end
  end

    get '/rosters/create' do 
     if logged_in?
      @user = current_user 
      erb :'rosters/create'
    else
      flash[:message] = "You must login to create a roster!"
      redirect to '/users/login'
    end
  end

  get '/rosters/:slug' do 
    @roster = Roster.find_by_slug(params[:slug])
    erb :'/rosters/show'
  end


  post '/rosters/create' do 
    if !params[:roster_name].empty?
      @roster = Roster.create(roster_name: params[:roster_name], user_id: current_user.id)
      @roster.save
      flash[:message] = "#{@roster.roster_name} created!"
      redirect to "/rosters/#{@roster.slug}"
    elsif params[:roster_name].empty?
      flash[:message] = "Roster must have a name!"
      redirect to '/rosters/create'
    end
  end

   get '/rosters/:slug/edit' do 

    erb :'rosters/edit'
  end



end