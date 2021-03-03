class UsersController < ApplicationController
   
   get '/users' do   
   end

    get '/signup' do
        erb :"/users/signup"
    end
end