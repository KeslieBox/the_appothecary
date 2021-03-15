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

        if !@user
            erb :"/users/login"
        else
            @products = current_user.products
            @categories = current_user.categories.uniq
            erb :"/users/show"
        end
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
            flash[:message] = ["Logged in successfully"]
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