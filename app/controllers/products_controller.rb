class ProductsController < ApplicationController
    get '/products' do 
        redirect_if_not_logged_in
        @products = current_user.products
        # should these go here instead of in the view? if so, how to i access the product id?
        # find the cat_prod object associated with the product
        # should this be current_user.categories_products...?
        # @categories_product = CategoriesProduct.find_by(product_id: product.id)
        # find the category object who's id is the same as the cat_prod category id
        # @category = current_user.categories.find_by(id: categories_product.category_id)
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

        if current_user.products.find_by(name: params[:product][:name])
            redirect "/products/#{product.id}"
        else  
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        end

    end
 
    get '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        if !@product 
            flash[:message] = ["Please select a product that exists"]
            redirect "/products"
        else
            @category = current_user.categories.find_by(id: categories_product.category_id)
            erb :"/products/show"
        end
        
        # need to figure out how to associate categories
        # @categories = current_user.categories_product
        # Category.find_by()...cat_prod_id: params[:id]??
        # categories where cat_product id = category id
        # if CategoriesProducts.all.each.detect {|cat_prod| cat_prod.id == category.id}
        # User.joins(products: {categories_product: :category})
        # @categories.each do |category|
        # end
        
        
    end
    
    get '/products/:id/edit' do
        redirect_if_not_logged_in
        # need to figure out how to associate categories and make instance variable to access in view
        @product =  current_user.products.find_by(id: params[:id])

        @products = current_user.products
        @category = current_user.categories.find_by(id: params[:id])
        @categories = current_user.categories

        if !@product 
            redirect "/products"
        end

        erb :"/products/edit"
    end

    patch '/products/:id' do
        redirect_if_not_logged_in
        @product =  current_user.products.find_by(id: params[:id])
        # @category = Category.find_by(id: params[:id])
        @product.update(params[:product])
        # @category.update(params[:category])
      
        erb :"/products/show"        
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        @product.delete
        redirect "/products"
    end
end
