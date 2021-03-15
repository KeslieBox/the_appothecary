class ProductsController < ApplicationController
    get '/products' do 
        redirect_if_not_logged_in
        @products = current_user.products
       
        erb :"/products/index"
    end
 
    get '/products/new' do
        redirect_if_not_logged_in
        @products = current_user.products
        @categories = Category.all
        erb :"/products/new"
    end
 
    post '/products' do
        redirect_if_not_logged_in
        @categories = Category.all
        category = Category.find_or_create_by(name: params[:category][:name].upcase)
        if !category.valid? && !params["category"]["name"].empty? 
            @errors = category.errors.full_messages
            erb :"/products/new"
        elsif category && !params["category"]["name"].empty?
            flash[:success] = ["Your category was successfully created!", "See checkboxes below to add the new category to this product", "Finish creating your product and click \"Create Product\" when you\'re done!"]
            redirect "/products/new"
        end
        
        if params[:product][:name].empty?
            @errors = ["Name can't be empty"]
            erb :"/products/new"
        elsif current_user.products.find_by(name: params[:product][:name])
            @errors = ["Please enter a product that doesn't already exist"]  
            erb :"/products/new"
        else
            params[:product][:name] = params[:product][:name].upcase
            @product = current_user.products.create(params[:product])
            flash[:success] = ["Your new product was created successfully!"]
            redirect "/products/#{@product.id}"
        end
    end

    get '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])

        if !@product 
            flash[:message] = ["Whoops! That product doesn't exist!"]
            redirect "/products"
        else
            @categories = @product.categories
            @category = current_user.categories.find_by(id: params[:id])
            erb :"/products/show"
        end
    end
    
    get '/products/:id/edit' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        @products = current_user.products
        @categories = Category.all
        @product_categories = @product.categories

        if !@product 
            flash[:message] = ["Whoops! That product doesn't exist!"]
            redirect "/products"
        end

        erb :"/products/edit"
    end

    patch '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        
        category = Category.find_or_create_by(name: params[:category][:name].upcase)
        if !category.valid? && !params["category"]["name"].empty?
            flash[:message] = category.errors.full_messages
            redirect "/products/#{@product.id}/edit"
        elsif category && !params["category"]["name"].empty?
            @product.update(params[:product])
            flash[:success] = ["Your category was added successfully!", "See checkboxes below to add the new category to this product", 'Finish editing your product and click "Edit Product" to submit your changes']
            redirect "/products/#{@product.id}/edit"
        else
            @product.update(params[:product])
            @product_categories = @product.categories
            # binding.pry
            flash[:message] = ["Your product was updated successfully!"]
            redirect "/products/#{@product.id}" 
        end
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        if check_user(@product)
            @product.delete
            redirect "/products"
        else
            @errors = ["Invalid option"]
            erb :"/products/show"
        end
    end
end
