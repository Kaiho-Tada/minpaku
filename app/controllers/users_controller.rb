class UsersController < ApplicationController
    skip_before_action :authenticate, only: [:new, :create]
    before_action :ensure_correct_user, only: [:show, :edit, :update]
    before_action :forbit_login_user, only: [:new, :create]
    def index
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:name, :email, :password))
       if @user.save
            session[:user_id] = @user.id
           flash[:notice] = "登録しました"
           redirect_to @user
       else
           render "users/new"
       end
    end

    def show
        @user = User.find(params[:id])
        
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(params.require(:user).permit(:name, :email, :password, :introduction, :avatar))
            flash[:notice] = "ユーザー情報を編集しました"
            redirect_to @user
        else
            render "edit"
        end
    end

    def destroy
    end

    def ensure_correct_user
        if current_user.id != params[:id].to_i
            flash[:notice] = "権限がありません"
            redirect_to root_path
        end
    end


end
