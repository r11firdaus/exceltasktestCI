# frozen_string_literal: true

# posts controller only can accessed if user has logged in
class PostsController < ApplicationController
  before_action :user_signed_in?

  def index
    find_post
    export_excel(params[:currpage].to_i)
    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=#{DateTime.now}-posts.xlsx"
      end
      format.html { render :index }
      format.json { render json: @posts }
    end
  end

  def find_post
    @posts = Post.joins(:user).search(params[:search])
                 .select('posts.*, users.id as user_id, users.username, users.role')
                 .order('posts.created_at DESC').page(params[:page]).per(10)

    @posts = @posts.where(['user_id = ?', session[:user_id].to_s]) if session[:role] != 'admin'
  end

  def export_excel(page)
    thispage = page > 1 ? page - 1 : page
    @pageposts = params[:type] == 'all' ? Post.all : Post.order('created_at DESC').limit(10).offset(thispage * 10 || 1)
    @pageposts = @pageposts.where(['user_id = ?', session[:user_id].to_s]) if session[:role] != 'admin'
  end

  def show
    @post = Post.joins(:user).select('posts.*, users.id as user_id, users.username').find(params[:id])
    @post.user_id == session[:user_id] ? show_response : redirect_to(posts_path)
  end

  def show_response
    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.pdf do
        export_pdf
      end
    end
  end

  def export_pdf
    save_path = Rails.root.join('public', "#{@post.id}.pdf")
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

  def create
    # @post = Post.new(post_params)
    # @post.user_id = session[:user_id]
    # respond_create
  end

  def respond_create
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
