class AuthController < ApplicationController
	def form_register
        @user = User.new
    end

    def register
        @user = User.new(user_params)

        username = User.find_by(username: @user.username)

        if username
            redirect_to edit_user_path(@user) , alert: "username sudah terdaftar"
        else
            if @user.save
                 redirect_to form_login_path, notice: "Berhasil membuat akun!"
            else
                render :form_register
            end
        end
    end

    def form_login

    end

    def login
        username = params[:username]
        password = params[:password]
        
        user = User.find_by(username: username)
        if user
            if user.authenticate(password)
                # membuat session dengan key = :user_id
                session[:user_id] = user.id
                redirect_to posts_path, notice: "Selamat datang #{user.username}"
            else
                redirect_to form_login_path, alert: "Password tidak sesuai"
            end
        else
            redirect_to form_login_path, alert: "email tidak ditemukan"
        end
    end

    def logout
        reset_session
        redirect_to form_login_path, notice: "Anda telah logout"
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :province, :city, :district)
    end
end
