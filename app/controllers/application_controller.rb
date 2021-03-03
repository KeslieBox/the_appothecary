require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret_of_herbs'
  end

  get '/' do
    erb :"/index"
  end

  # get '/signup' do
  #   erb :"/users/signup"
  # end



end
