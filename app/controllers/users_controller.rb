class UsersController < ApplicationController

    get '/users' do   
    end
    
    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :"/users/signup"
    end

    post '/signup' do 
        user = User.create(params)
        # binding.pry
        # need to make sure username is not empty
        if user.id 
          session[:user_id] = user.id
          redirect "/users/#{user.id}"
        else
          @errors = user.errors.full_messages
          erb :'/users/signup'
        end
    end

    get '/users/:id' do
        redirect_if_not_logged_in
        @user = User.find_by(id: params[:id])
        @herbs = Herb.all
        @tinctures = Tincture.all
        @products = Product.all

        erb :"/users/show"
    end

    get '/login' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        end
        erb :"/users/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id
            flash[:message] = "Logged in successfully"
            redirect "/users/#{user.id}"
        else 
           @errors = ["Invalid login, please make sure your username and password are correct"]
            erb :"/users/login"
        end 
    end

    get '/logout' do
        session.clear
        redirect "/"
    end

end