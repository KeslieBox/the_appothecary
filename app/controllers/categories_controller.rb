class CategoriesController < ApplicationController
    get '/categories' do  
        redirect_if_not_logged_in
        @products = current_user.products
        @categories = current_user.categories
        
        erb :"/categories/index"
    end
 
    get '/categories/new' do
        redirect_if_not_logged_in
        @categories = current_user.categories
        erb :"/categories/new"
    end

    post '/categories' do
        redirect_if_not_logged_in
        # if category name does already exists in user's categories and is not nil redirect to /categories/new
        # if current_user.categories.each.detect do |category| category.name == params[:category][:name]}
        if current_user.categories.find_by(name: params[:category][:name])
            flash[:message] = ["Please enter a category that doesn't already exist"]
            redirect "/categories/new"
        # else if it doesnt exist, redirect to categories to see new category there
        else
            category = current_user.categories.create(params[:category])
            categories_product.category_id = category.id
            redirect "/categories"
        end
    end
 
    get '/categories/:id' do
        redirect_if_not_logged_in
        # need to find products that belong to category...products with current category id
        @product = Product.find_by(id: params[:id])
        @category = Category.find_by(id: params[:id])
        @products = current_user.products

        # if !@product || !@category
        #     redirect "/categories"
        # end

        erb :"/categories/show"
    end
    
    get '/categories/:id/edit' do
        redirect_if_not_logged_in

        @category = Category.find_by(id: params[:id])
        @categories = current_user.categories

        erb :"/categories/edit"
    end

    patch '/categories/:id' do
        redirect_if_not_logged_in
        @category = Category.find_by(id: params[:id])
        @category.update(params[:category])
        @products = current_user.products
      
        erb :"/categories/show"        
    end

    delete '/categories/:id' do
        redirect_if_not_logged_in
        @category = Category.find_by(id: params[:id])
        @category.delete
        redirect "/categories"
    end
end
