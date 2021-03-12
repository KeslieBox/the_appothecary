class CategoriesController < ApplicationController
    get '/categories' do  
        redirect_if_not_logged_in
        @categories = current_user.categories.uniq
        # @categories = Category.all
        
        erb :"/categories/index"
    end
 
    get '/categories/new' do
        redirect_if_not_logged_in
        erb :"/categories/new"
    end

    post '/categories' do
        redirect_if_not_logged_in
        categories = Category.all
        #make sure capitalize doesn't need downcase
        
        category = Category.find_or_create_by(name: params[:category][:name].capitalize)

        if !category
            flash[:message] = category.errors.full_messages
            redirect "/categories/new"
        else
            # same issue as get "/categories" above, how do i only render it in the view if it is associated with current user       
            flash[:message] = ["Your new category was added successfully!"]
            redirect "/categories"
        end
    end
 
    get '/categories/:id' do
        redirect_if_not_logged_in
        # @category = Category.find_by(id: params[:id])
        @category = current_user.categories.find_by(id: params[:id])
        # binding.pry
        if !@category || @category.products.empty?
            redirect "/categories"
        else
        # elsif @category.products
            # how to access all the products for a category for THIS user??
            # @products = @category.products.find_by(user: current_user)
            @products = @category.products

            # current_user.products.each.select do |product|
                # select all products that belong to this category    
            # end 
            erb :"/categories/show"
        end    
    end
    
    get '/categories/:id/edit' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])
        if !@category 
            flash[:message] = ["Whoops! That category doesn't exist!"]
            redirect "/products"
        end
        erb :"/categories/edit"
    end

    patch '/categories/:id' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])
        @category.update(params[:category])
        @products = @category.products
      
        erb :"/categories/show"        
    end

    delete '/categories/:id' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])
        if @category
            @category.delete
            redirect "/categories"
        else
            @errors = ["Invalid option"]
            erb :"/categories/show"
        end
    end
end
