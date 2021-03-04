class HerbsController < ApplicationController
    get '/herbs' do  
        erb :"/herbs/show"
    end
 
    get '/herbs/new' do
        erb :"/herbs/new"
    end

    post '/herbs' do
        redirect_if_not_logged_in

        herb = current_user.items.create(params[:herb])
        binding.pry
        if herb.valid?
            redirect "/herbs/#{herb.id}"
        else  
            flash[:message] = herb.errors.full_messages  
            redirect "/herbs/new"
        end
    end
end
