class ApplicationController < ActionController::Base
    before_action :authenticate
    helper_method :logged_in?, :current_user
    
    private
    def logged_in?
        !! current_user
    end

    def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
    end

    def authenticate
        return if logged_in?
        flash[:notice] = "ログインしてください"
        redirect_to root_path
    end
    
    def forbit_login_user
        if current_user
            flash[:notice] = "既にログインしています"
            redirect_to root_path
        end
    end
end
