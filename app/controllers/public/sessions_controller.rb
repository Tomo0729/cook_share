# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
 before_action :user_state, only: [:create]

 def guest_sign_in
    user = User.guest # ← user.rbで定義したメソッド
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
 end



 protected
 
# 退会しているかを判断するメソッド
 def user_state
  @user = User.find_by(email: params[:user][:email])
  if @user
    if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
     flash[:error] = "退会済みです。"
     redirect_to new_user_session_path
    end
  else
   flash[:error] = "必要項目を入力してください"
  end
 end



  #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
