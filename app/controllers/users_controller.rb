class UsersController < ApplicationController
  skip_before_action :authorize_user!, only: [:show, :create]

  before_action :set_user, only: [:show, :update, :destroy]

  # GET users/:id
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render_errors(@user.errors)
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render_errors(@user.errors)
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:first_name, :last_name, :email, :time_zone)
  end
end
