ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative './datamapper_setup'
setup

class MakersBnB < Sinatra::Base
  get '/' do
    'Hello MakersBnB!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
