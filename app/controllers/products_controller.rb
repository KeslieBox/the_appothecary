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

    ##this is working but with no option to add new category 
    # post '/products' do
    #     redirect_if_not_logged_in
    #     params[:product][:name] = params[:product][:name].capitalize
    #     product = current_user.products.create(params[:product])
        
    #     if !product.valid?
    #         flash[:message] = product.errors.full_messages  
    #         redirect "/products/new"
    #     else
    #         flash[:success] = ["Your new product was added successfully!"]
    #         redirect "/products/#{product.id}"
    #     end
    # end

    #trying to create an option to add new category at the same time you add a new product
    post '/products' do
        redirect_if_not_logged_in
        @categories = Category.all
        params[:product][:name] = params[:product][:name].capitalize
        product = current_user.products.create(params[:product])

        category = Category.find_or_create_by(name: params[:category][:name].capitalize)
        if !category.valid? && !params["category"]["name"].empty? 
            # flash[:message] = category.errors.full_messages
            # redirect "/products/new"
            @errors = category.errors.full_messages
            erb :"/products/new"
        elsif category && !params["category"]["name"].empty?
            # @product.update(params[:product])
            flash[:success] = ["Your category was added successfully! See checkboxes below to add the new category to this product", "Finish creating your product and click \"Create Product\" when you\'re done"]
            redirect "/products/new"
        end
        
        if !product.valid?
            flash[:message] = product.errors.full_messages  
            redirect "/products/new"
        else
            flash[:success] = ["Your new product was created successfully!"]
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
# this is working with no option to add new category in edit
    # patch '/products/:id' do
    #     redirect_if_not_logged_in
    #     @product = current_user.products.find_by(id: params[:id])
    #     @product.update(params[:product])
    #     # binding.pry
    #     # @category = current_user.categories.find_by(id: params[:product][:category_ids])
    #     # @category.update(params[:category])
      
    #     redirect "/products/#{@product.id}"      
    # end

# trying to create option to add new category from edit page
    patch '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        
        category = Category.find_or_create_by(name: params[:category][:name].capitalize)
        if !category.valid? && !params["category"]["name"].empty?
            flash[:message] = category.errors.full_messages
            redirect "/products/#{@product.id}/edit"
        elsif category && !params["category"]["name"].empty?
            @product.update(params[:product])
            flash[:success] = ["Your category was added successfully! See checkboxes below to add the new category to this product", 'Finish editing your product and click "Edit Product" to submit your changes']
            redirect "/products/#{@product.id}/edit"
        else
            @product.update(params[:product])
            @product_categories = @product.categories
            # binding.pry
            flash[:message] = ["Your product was updated successfully!"]
            redirect "/products/#{@product.id}" 
        end
        # redirect "/products/#{@product.id}"     
    end

    delete '/products/:id' do
        redirect_if_not_logged_in
        @product = current_user.products.find_by(id: params[:id])
        @product.delete
        redirect "/products"
    end
end
