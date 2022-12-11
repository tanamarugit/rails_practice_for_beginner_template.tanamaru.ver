class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: "ユーザー「#{@user.name}を登録しました。」"
    else
      flash.now[:alert] = "ユーザー#{@user.name}の新規作成に失敗しました。"
      render :action => :new
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    session[:user_id] = nil
    @user.destroy!
    redirect_to new_user_path flash[:notice] = 'ユーザーを削除しました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
