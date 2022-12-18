class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: "ユーザー「#{@user.name}]を登録しました。"
    else
      flash.now[:alert] = "ユーザー#{@user.name}の新規作成に失敗しました。"
      render users_path
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy!
      redirect_to questions_path, notice: "ユーザー「#{@user.name}」を削除しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
