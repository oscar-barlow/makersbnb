ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'data_mapper'
require_relative './models/user'
require_relative './models/booking'
require_relative './models/listing'
require_relative './models/unavailable'
require_relative 'datamapper_setup'

setup
require 'pry'

class MakersBnB < Sinatra::Base

  use Rack::MethodOverride
  register Sinatra::Flash
  register Sinatra::Partial

  enable :sessions
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb

  enable :partial_underscores

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
    @listing = Listing.create(name: params[:name], price: params[:price], description: params[:description], user_id: current_user.id)
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
    @unavailables = Unavailable.all(listing_id: params[:id])
    erb :'listing/get'
  end

  get '/listing/:id/booking/new' do
    @listing_id = Listing.get(params[:id]).id
    erb :'booking/new'
  end

  post '/listing/:id/booking' do
    @listing_id = Listing.get(params[:id]).id
    booking = Booking.create(user_id: current_user.id,
                              listing_id: params[:id],
                              check_in: params[:check_in],
                              message: params[:message])
    redirect "/listing/#{@listing_id}/booking/confirmation"
  end

  get '/listing/:id/booking/confirmation' do
    erb :'booking/confirmation'
  end

  get '/listing/:id/unavailable/new' do
    @listing_id = params[:id]
    erb :'unavailable/new'
  end

  post '/listing/:id/unavailable' do
    @listing_id = params[:id]
    @unavailable = Unavailable.create(date: params[:date], listing_id: @listing_id )
    redirect("/listing/#{@listing_id}")
  end

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
