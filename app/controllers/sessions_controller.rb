class SessionsController < ApplicationController
    skip_before_action :authenticate
    before_action :forbit_login_user, only: [:new, :create]
    def new
        @user = User.new
        
    end

    def create
        @user = User.find_by(email: params[:email], password: params[:password])
       if @user
            session[:user_id] = @user.id
           flash[:notice] = "ログインしました"
           redirect_to root_path
       else
            @error_message = "メールアドレスまたはパスワードが間違えています"
           render "sessions/new"
       end
    end

    def destroy
        reset_session
        flash[:notice] = "ログアウトしました"
        redirect_to root_path
    end
end
