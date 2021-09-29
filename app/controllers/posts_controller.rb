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
    session[:userdata]['role'] == 'admin' ? find_post_admin : find_post_writer
  end

  def find_post_admin
    @posts = Post.joins(:user).search(params[:search])
                 .select('posts.*, users.id as user_id, users.username, users.role')
                 .order('posts.created_at DESC').page(params[:page]).per(10)
  end

  def find_post_writer
    @posts = Post.joins(:user).search(params[:search])
                 .select('posts.*, users.id as user_id, users.username, users.role')
                 .order('posts.created_at DESC').page(params[:page]).per(10)
                 .where('user_id = ?', session[:userdata]['id'])
  end

  def export_excel(page)
    thispage = page > 1 ? page - 1 : page
    @pageposts = ExportExcel.new(
      page: thispage,
      role: session[:userdata]['role'],
      type: params[:type],
      id: session[:userdata]['id']
    ).export
  end

  def show
    @post = Post.joins(:user).select('posts.*, users.id as user_id, users.username').find(params[:id])
    if @post.user_id == session[:userdata]['id'] || session[:userdata]['role'] == 'admin'
      show_response
    else
      redirect_to(posts_path)
    end
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
    process = ExportPdf.new(post: @post).export
    send_file process, disposition: :inline
    DeletePdfJob.set(wait: 1.minutes).perform_later(@post.id)
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
    @post = Post.new(post_params)
    @post.user_id = session[:userdata]['id']
    redirect_to @post if @post.save
    respond_to do |format|
      format.js
    end
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
