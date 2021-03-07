require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret_of_herbs'
  end

  register Sinatra::Flash

  get '/' do
    erb :"/index"
  end

  helpers do
    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    # def categories_product
    #   @categories_product = CategoriesProduct.create
    # end

    def logged_in?
      !!session[:user_id]
    end  

    def redirect_if_not_logged_in
        redirect '/login' unless current_user
    end

    def redirect_if_not_owner(obj)
      if !check_owner(obj)
        flash[:message] = "Looks like you're not logged in, login to see your account"
        redirect '/products'
      end
    end

    def check_owner(obj)
        obj && obj.user == current_user
    end
  end



end
