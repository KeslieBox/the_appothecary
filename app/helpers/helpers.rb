class Helpers

    def self.current_user(session)
        @user = User.find_by(id: session[:user_id])
    end
  
    def self.logged_in?(session)
      !!session[:user_id]
    end  

    def redirect_if_not_logged_in
        redirect '/login' unless current_user
    end

    def check_owner(obj)
        obj && obj.user == current_user
    end
    
  end




