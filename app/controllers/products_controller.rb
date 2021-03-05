class ProductsController < ApplicationController
    get '/products' do  
        redirect_if_not_logged_in
        @products = current_user.products
        erb :"/products/index"
    end
 
    get '/products/new' do
        redirect_if_not_logged_in
        erb :"/products/new"
    end

    post '/products' do
        redirect_if_not_logged_in
        
        product = current_user.products.create(params[:product])

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
        # redirect_if_not_owner(@product)
        if !@product
            redirect "/products"
        end

        erb :"/products/show"
    end
    
    get '/products/:id/edit' do
        redirect_if_not_logged_in

        @product = Product.find_by(id: params[:id])
        @products = Product.all

        erb :"/products/edit"
    end

    patch '/products/:id' do
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        @product.update(params[:product])
      
        erb :"/products/show"        
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        @product.delete
        redirect "/products"
    end
end
