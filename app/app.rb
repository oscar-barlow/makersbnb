ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'

require 'data_mapper'
require_relative './models/user'
require_relative 'datamapper_setup'
setup

class MakersBnB < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'Hello MakersBnB!'
  end

  get '/sign_up' do
   erb :sign_up
  end

  post '/new_user' do
    @user = User.create(username: params[:username],
                        email: params[:email],
                        password: params[:password])
    session[:user_id] = @user.id
    session[:username] = @user.username
    redirect '/listing/new'
  end

  # get '/listing' do # this is a prime candidate for renaming/repurposing...
  #   erb :listing
  # end

  get '/listing/new' do
    if !current_user
      redirect '/'
    else
      erb :'listing/new'
    end
  end

  post '/listing' do
    Listing.create(name: params[:name], price: params[:price], description: params[:description], user_id: current_user.id)
    redirect('/user/listings')
  end

  get '/user/listings' do
    @listings = Listing.all(user_id: current_user.id)
    erb :'users/listings'
  end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
