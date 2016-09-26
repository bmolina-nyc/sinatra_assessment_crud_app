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
    @roster = Roster.find_by_slug(params[:slug])

    if !current_user.rosters.include?(@roster)
      flash[:message] = "You cannot edit a roster you didn't create!"
      redirect to '/rosters/index'
    else
      @user = current_user
      erb :'rosters/edit'
    end
  end

  post '/rosters/:slug/edit' do 

    @roster = Roster.find_by_slug(params[:slug])
    if params[:roster_name].empty?
      flash[:message] = "Roster must have a name!"
      redirect to '/rosters/:slug/edit'
    else
      @roster.roster_name = params[:roster_name]
      @roster.save
      flash[:message] = "Roster name updated!"
      redirect to '/rosters/index'
    end
  end

  delete '/rosters/:slug/delete' do 
    @roster = Roster.find_by_slug(params[:slug])
    
    @roster.players.each do |player|
      player.delete
    end 
    @roster.delete

    flash[:message] = "Roster and all players deleted from #{current_user.username} rosters"
    redirect to '/users/index'
  end 



end