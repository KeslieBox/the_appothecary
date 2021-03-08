class CategoriesController < ApplicationController
    get '/categories' do  
        redirect_if_not_logged_in
        @categories = Category.all
        
        erb :"/categories/index"
    end
 
    get '/categories/new' do
        redirect_if_not_logged_in
        @categories = current_user.categories
        erb :"/categories/new"
    end

    post '/categories' do
        redirect_if_not_logged_in
       
        if Category.find_by(name: params[:category][:name]) || Category.find_by(name: params[:category][:name].capitalize) || Category.find_by(name: params[:category][:name].upcase)
            flash[:message] = ["Please enter a category that doesn't already exist"]
            redirect "/categories/new"
        # else if it doesnt exist, redirect to categories to see new category there
        else
            Category.find_or_create_by(name: params[:category][:name])
            redirect "/categories"
        end
    end
 
    get '/categories/:id' do
        redirect_if_not_logged_in
        @category = Category.find_by(id: params[:id])

        if !@category
            redirect "/categories"
        else
            # how to access all the products for a category??
            @products = @category.products
            # current_user.products.each.select do |product|
                # select all products that belong to this category    
            # end 
        end    

        erb :"/categories/show"
    end
    
    get '/categories/:id/edit' do
        redirect_if_not_logged_in

        @category = current_user.categories.find_by(id: params[:id])
        @categories = current_user.categories

        erb :"/categories/edit"
    end

    patch '/categories/:id' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])
        @category.update(params[:category])
        @products = current_user.products
      
        erb :"/categories/show"        
    end

    delete '/categories/:id' do
        redirect_if_not_logged_in
        @category = current_user.categories.find_by(id: params[:id])
        # need to make sure this is only accesible to owner of products in this category
        binding.pry
        # if @category
            @category.delete
            redirect "/categories"
        # else
        #     # set up errors
        #     @errors = ["Invalid option"]
        #     erb :"/categories/show"
        # end
    end
end
