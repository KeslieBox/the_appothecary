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

        params[:product][:name] = params[:product][:name].capitalize
        product = current_user.products.create(params[:product])
        
        if !product.valid?
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        else
            flash[:message] = ["Your new product was added successfully!"]
            redirect "/products/#{product.id}"
        end
    end
 
    get '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])

        if !@product 
            flash[:message] = ["Whoops! That product page doesn't exist!"]
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
        @product.update(params[:product])
        # binding.pry
        # @category = current_user.categories.find_by(id: params[:product][:category_ids])
        # @category.update(params[:category])
        # binding.pry
        if !params["category"]["name"].empty?
            category = Category.find_or_create_by(name: params[:category][:name].capitalize)
        end
        redirect "/products/#{@product.id}"     
        
#         # if !params[:category][:name].empty?
#         category = Category.find_or_create_by(name: params[:category][:name].capitalize)
#         if !category
#             flash[:message] = category.errors.full_messages
#             redirect "/products/#{@product.id}"
#         else
#             # same issue as get "/categories" above, how do i only render it in the view if it is associated with current user       
#             flash[:message] = ["Your new category was added successfully!"]
#             redirect "/categories"
#         end
# # end
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        @product.delete
        redirect "/products"
    end
end
