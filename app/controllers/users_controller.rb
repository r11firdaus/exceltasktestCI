# frozen_string_literal: true

# only the users can edit their data, but for roles, only admin can assign it to users
class UsersController < ApplicationController
  require 'ostruct'
  before_action :user_signed_in?
  # before_action :set_user, only: %i[show edit update destroy]
  before_action :set_user, only: %i[edit update destroy]
  before_action :validate_role, only: %i[index]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    current_user = OpenStruct.new(session[:userdata])
    @user = current_user.id == params[:id] ? OpenStruct.new(session[:userdata]) : set_user
    validate_user(@user)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def validate_role
    @user = User.find(session[:userdata]['id'])
    redirect_to root_path if @user.role_id != 1
  end

  def validate_user(user)
	redirect_to(posts_path) if session[:userdata]['role_id'] != 1 && (user.id != session[:userdata]['id'])
  end

  # GET /users/1/edit
  def edit
    validate_user(@user) 
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    @user.save ? show_response(true, @user) : show_response(false, @user)
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update 
    if @user.update(user_params)
      session[:userdata] = @user if session[:userdata]['id'].to_i == @user.id
      show_response(true, @user)
    else
      show_response(false, @user)
    end
  end

  def show_response(status, user)
    respond_to do |format|
      if status
        format.html { redirect_to user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :role_id, :province, :city, :district)
  end
end
