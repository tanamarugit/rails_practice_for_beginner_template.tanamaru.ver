class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました。'
      redirect_to users_path
    else
      flash[:notice] = 'ログインできませんでした。'
      render sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to sessions_new_path
  end

  private 
  
  def session_params
    params.permit(:email, :password)
  end

end
