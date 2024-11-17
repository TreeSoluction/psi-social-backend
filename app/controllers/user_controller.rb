class UserController < ApplicationController
  before_action :authorize_request, except: :create

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_column(:name, user_update_params[:name])
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def user_update_params
    params.require(:user).permit(:name)
  end
end
