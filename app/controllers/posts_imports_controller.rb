class PostsImportsController < ApplicationController
  def new
    @posts_import = PostsImport.new
  end

  def create
    @posts_import = AddPostWorkerJob.perform_now(params[:posts_import])
    if @posts_import
      redirect_to posts_path
    else
      render :new
    end
  end
end