ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require 'data_mapper'
require_relative './models/user'
require_relative 'datamapper_setup'
setup
require 'pry'

class MakersBnB < Sinatra::Base

  use Rack::MethodOverride
  register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    @listings = Listing.all
    erb :index
  end

  get '/user/new' do
   erb :'user/new'
  end

  post '/user' do
    @user = User.create(username: params[:username],
                        email: params[:email],
                        password: params[:password])

    if @user.save
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect '/'
    else
      flash.next[:errors] = @user.errors.full_messages
      redirect '/user/new'
    end
  end

  get '/session/new' do
    if session[:user_id] != nil
      redirect '/'
    else
      erb :'session/new'
    end
  end

  post '/session' do
    user = User.authenticate(params[:username], params[:password])
      if user
         session[:user_id] = user.id
          session[:username] = user.username
          redirect '/'
      else
        flash.next[:notice] = "Your details are incorrect"
        redirect '/session/new'
      end
  end

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
    erb :'user/listings'
  end

  delete '/session' do
    session[:user_id] = nil
    redirect to '/session/new'
  end

  get '/listing/:id' do
    @listing = Listing.get(params[:id])
    erb :'listing/get'
  end


helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
