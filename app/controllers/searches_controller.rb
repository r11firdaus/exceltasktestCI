class SearchesController < ApplicationController
	def show
        @search = Search.find(params[:id])
        @posts = @search.search_post.page(params[:page]).per(10)
        # @search = Search.search(params[:title], params[:body]).page(params[:page]).per(10)
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