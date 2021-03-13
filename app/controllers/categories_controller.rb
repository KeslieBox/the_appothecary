class CategoriesController < ApplicationController
    get '/categories' do  
        redirect_if_not_logged_in
        @categories = current_user.categories.uniq
        
        erb :"/categories/index"
    end
 
    get '/categories/new' do
        redirect_if_not_logged_in
        erb :"/categories/new"
    end

    post '/categories' do
        redirect_if_not_logged_in
        categories = Category.all        
        category = Category.find_or_create_by(name: params[:category][:name].capitalize)

        if !category
            flash[:message] = category.errors.full_messages
            redirect "/categories/new"
        else
            flash[:message] = ["Your new category was added successfully!", "Please add some new products to your category to see them here!"]
            redirect "/categories"
        end
    end
 
    get '/categories/:id' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])

        if !@category
            flash[:message] = ["Whoops that category doesn't exist yet!"]
            redirect "/categories"
        else
            @products = @category.products.where(user: current_user)
           
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
