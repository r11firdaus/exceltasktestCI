# frozen_string_literal: true

class AuthController < ApplicationController
  def form_register
    redirect_to posts_path if session[:user_id]
    @user = User.new
  end

  def register
    @user = User.new(user_params)
    username = User.find_by(username: @user.username)

    if username
      redirect_to edit_user_path(@user), alert: 'username sudah terdaftar'
    elsif @user.save
      redirect_to form_login_path, notice: 'Berhasil membuat akun!'
    else
      render :form_register
    end
  end

  def form_login
    redirect_to posts_path if session[:user_id]
  end

  def login
    user = User.find_by(username: params[:username])
    if user
      check_user_login(user)
    else
      redirect_to form_login_path, alert: 'Username tidak ditemukan'
    end
  end

  def check_user_login(user)
    if user.authenticate(params[:password])
      # membuat session dengan key = :user_id
      session[:user_id] = user.id
      session[:role] = user.role
      redirect_to posts_path, notice: "Selamat datang #{user.username}"
    else
      redirect_to form_login_path, alert: 'Password tidak sesuai'
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
