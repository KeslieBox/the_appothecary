require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret_of_herbs'
  end

  register Sinatra::Flash

  get '/' do
    erb :"/index"
  end

  helpers do
    def current_user
      @user = User.find_by(id: session[:user_id])
    end

    def product_new_category
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
        # erb :"/products/show"
      end
    end

    def logged_in?
      !!session[:user_id]
    end  

    def redirect_if_not_logged_in
        redirect '/login' unless current_user
    end

    def redirect_if_not_owner(obj)
      if !check_owner(obj)
        flash[:message] = "Looks like you're not logged in, login to see your account"
        redirect '/products'
      end
    end

    def check_owner(obj)
        obj && obj.user == current_user
    end
  end



end
