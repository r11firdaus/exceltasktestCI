class ApplicationController < ActionController::Base
	# mencari user berdasarkan session key
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        else
            nil
        end
    end

    # cek apakah user sudah login
    def user_signed_in?
        if current_user
            true
        else
            redirect_to form_login_path, alert: "Silahkan login terlebih dahulu!"
            return false
        end
    end
end
