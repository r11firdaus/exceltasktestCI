class PostsController < ApplicationController
  def index
    @posts = Post.order('created_at DESC').page(params[:page]).per(10)
    @type = params[:type]
    @currpage = params[:currpage].to_i

    if params[:currpage].to_i > 1
      @currpage - 1
    end

    if @type == "all"
      @pageposts = Post.all
    else
      @pageposts = Post.order('created_at DESC').limit(10).offset(@currpage * 10 || 1)
    end

    @allcomments = Comment.order('post_id')
    respond_to do |format|
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=#{DateTime.now}-posts.xlsx"
      }
      format.html { render :index }
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        save_path = Rails.root.join("public", "#{@post.id}.pdf")
        if File.exist?(save_path)
          # send pdf data
          send_file save_path, disposition: :inline
        else
          # kick off the job and render the default template for this action
          AddPdfJob.perform_now(@post)
          send_file save_path, disposition: :inline
          DeletePdfJob.set(wait: 1.minutes).perform_later(@post.id)
        end
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
 
    redirect_to posts_path
    end
 
  private
 
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end