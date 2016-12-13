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
      redirect '/listing1'
    else
      flash.next[:errors] = @user.errors.full_messages
      redirect '/sign_up'
    end
  end

  get '/log_in' do
    if session[:user_id] != nil
      redirect '/listing1'
    else
      erb :log_in
    end
  end

  post '/existing_user' do
    user = User.authenticate(params[:username], params[:password])
      if user
         session[:user_id] = user.id
          session[:username] = user.username
          redirect '/listing1'
      else
        flash.next[:notice] = "Your details are incorrect"
        redirect '/log_in'
      end
  end

  get '/listing1' do # this is a prime candidate for renaming/repurposing...
    erb :listing
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
