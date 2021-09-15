# frozen_string_literal: true

class ApplicationController < ActionController::Base
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
