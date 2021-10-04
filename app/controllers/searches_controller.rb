# frozen_string_literal: true

# create an advanced search and save to db
class SearchesController < ApplicationController
  before_action :user_signed_in?
  def show
    @search = Search.find(params[:id])
    @posts = @search.search_post.page(params[:page]).per(10)
    @posts = @posts.where(['user_id = ?', session[:userdata]['id'].to_s]) if session[:userdata]['role_id'] != 1
  end

  def new
    @search = Search.new
  end

  def create
    Search.delete_all
    @search = Search.create(search_params)
    redirect_to @search
  end

  private

  def search_params
    params.require(:search).permit(:title, :body)
  end
end
