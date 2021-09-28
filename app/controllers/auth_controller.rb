# frozen_string_literal: true

# Authtenticating user
class AuthController < ApplicationController
  def form_register
    redirect_to posts_path if session[:userdata]
    @user = User.new
  end

  def register
    @user = User.new(user_params)
    username = User.find_by(username: @user.username)

    if username
      redirect_to form_register_path, alert: 'username sudah terdaftar'
    elsif verify_recaptcha(model: @user) && @user.save
      redirect_to form_login_path, notice: 'Berhasil membuat akun!'
    else
      render :form_register
    end
  end

  def form_login
    redirect_to posts_path if session[:userdata]
  end

  def login
    user = User.find_by(username: params[:username])
    if user
      check_user_login(user)
    else
      redirect_to form_login_path, alert: 'Username atau Password salah'
    end
  end

  def check_user_login(user)
    if user.authenticate(params[:password])
      reset_session

      # membuat session dengan key = :userdata
      session[:userdata] = user
      redirect_to posts_path, notice: "Selamat datang #{user.username}"
    else
      redirect_to form_login_path, alert: 'Username atau Password salah'
    end
  end

  def logout
    reset_session
    redirect_to form_login_path, notice: 'Anda telah logout'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :province, :city, :district)
  end
end
