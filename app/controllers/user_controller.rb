class UserController < ApplicationController
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

  # TODO ADD BEARER TOKEN
  def login
    user = User.find_by(email: user_login_params[:email])
    if user && user.authenticate(user_login_params[:password])
      puts "logged in"
    else
      puts "wrong password"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
