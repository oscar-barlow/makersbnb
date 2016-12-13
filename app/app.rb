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
      flash.next[:errors] = @user.errors.full_messages
      redirect '/sign_up'
    end
  end

  get '/log_in' do
    if session[:user_id] != nil
      redirect '/listing'
    else
      erb :log_in
    end
  end

  post '/existing_user' do
    user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        redirect '/listing'
      else
        flash.next[:notice] = "Your details are incorrect"
        redirect '/log_in'
      end
  end

  get '/listing' do
    erb :listing
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect to '/log_in'
  end


helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
