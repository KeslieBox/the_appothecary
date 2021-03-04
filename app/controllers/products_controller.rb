class ProductsController < ApplicationController
    get '/products' do  
        @products = Product.all
        @product = Product.find_by(id: params[:id])
        erb :"/products/show"
    end
 
    get '/products/new' do
        @products = Product.all

        erb :"/products/new"
    end

    post '/products' do
        redirect_if_not_logged_in
        product = current_user.products.create(params)
        # need to figure out best way to check that they fill in form correctly
        if product.id
            redirect "/products/#{product.id}"
        else  
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        end
    end

    get '/products/:id' do
        redirect_if_not_logged_in

        @product = Product.find_by(id: params[:id])
        @products = Product.all

        if !@product
            redirect "/users/#{session[:id]}"
        end
        erb :"/products/show"
    end

    patch '/products/:id' do
        
    end
end
