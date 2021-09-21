# frozen_string_literal: true

# Auth in base app(find user is login or not)
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  # mencari user berdasarkan session key
  def current_user
    true if session[:user_id]
  end

  # cek apakah user sudah login
  def user_signed_in?
    if current_user
      true
    else
      redirect_to form_login_path, alert: 'Silahkan login terlebih dahulu!'
      false
    end
  end
end
