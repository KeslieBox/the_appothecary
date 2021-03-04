class ProductsController < ApplicationController
    get '/products' do  
        erb :"/products/show"
    end
 
    get '/products/new' do
        erb :"/products/new"
    end

    post '/products' do
        redirect_if_not_logged_in

        product = current_user.items.create(params[:product])
        binding.pry
        if product.valid?
            redirect "/products/#{product.id}"
        else  
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        end
    end
end
