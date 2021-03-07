class ProductsController < ApplicationController
    get '/products' do 
        redirect_if_not_logged_in
        @products = current_user.products
        erb :"/products/index"
    end
 
    get '/products/new' do
        redirect_if_not_logged_in
        @products = current_user.products
        @categories = current_user.categories
        erb :"/products/new"
    end

    post '/products' do
        redirect_if_not_logged_in
        product = current_user.products.create(params[:product])
        @categories_product = CategoriesProduct.create
        @categories_product.product_id = product.id
        @categories_product.category_id = params[:category][:id]
        @categories_product.save

        if current_user.products.find_by(name: params[:product][:name])
            redirect "/products/#{product.id}"
        else  
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        end

    end
 
    get '/products/:id' do
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        categories_product = CategoriesProduct.find_by(product_id: params[:id])
        @category = Category.find_by(id: categories_product.category_id)
        # @categories_product.category_id
        # @categories = current_user.categories_product
        # Category.find_by()...cat_prod_id: params[:id]??
        # need to figure out how to associate categories
        # categories where cat_product id = category id
        # if CategoriesProducts.all.each.detect {|cat_prod| cat_prod.id == category.id}


        # @categories.each do |category|
        # end
        # if !@product || !@category
        #     redirect "/products"
        # end

        erb :"/products/show"
    end
    
    get '/products/:id/edit' do
        redirect_if_not_logged_in
        # need to figure out how to associate categories and make instance variable to access in view
        @product = Product.find_by(id: params[:id])

        @products = current_user.products
        @category = Category.find_by(id: params[:id])
        @categories = current_user.categories

        if !@product 
            redirect "/products"
        end

        erb :"/products/edit"
    end

    patch '/products/:id' do
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        # @category = Category.find_by(id: params[:id])
        @product.update(params[:product])
        # @category.update(params[:category])
      
        erb :"/products/show"        
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
        @product.delete
        redirect "/products"
    end
end
