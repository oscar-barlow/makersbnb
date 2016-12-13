ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require 'data_mapper'
require_relative './models/user'
require_relative 'datamapper_setup'
setup

class MakersBnB < Sinatra::Base

  register Sinatra::Flash

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
    if @user.save
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect '/listing'
    else
      flash.next[:error] = "This user already exists, please change your details or log in"
      redirect '/sign_up'
    end
  end

  get '/log_in' do
    erb :log_in
  end

  post '/exisiting_user' do
    redirect '/listing'
  end

  get '/listing' do
    erb :listing
  end


helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
