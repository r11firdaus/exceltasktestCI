class SearchesController < ApplicationController
	def show
        @search = Search.find(params[:id])
        @posts = @search.search_post.page(params[:page]).per(10)

        @user = User.find(session[:user_id])

        if @user.role != 'admin'
          @posts = @posts.where(["user_id = ?", session[:user_id].to_s])
        end
        Search.delete_all
    end 

    def new 
        @search = Search.new
    end

    def create
        @search = Search.create(search_params)
        redirect_to @search
    end 

    private

    def search_params
        params.require(:search).permit(:title, :body)
    end 
end