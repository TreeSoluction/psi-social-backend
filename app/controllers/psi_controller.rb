class PsiController < ApplicationController
  before_action :authorize_request, except: [ :index, :show ]

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
    render json: Psi.all
  end

  def show
    entity = Psi.find(params[:id])
    render json: entity
  end

  def create
    entity = Psi.new(psi_register_params)
    puts entity
    if entity.save
      render json: entity, status: :created
    else
      render json: entity.errors, status: :unprocessable_entity
    end
  end

  def have
    entity = Psi.find_by!(user_id: params[:id])
    if entity
      render json: entity, status: :ok
    else
      render json: entity.errors, status: :not_found
    end
  end

  def update
    entity = Psi.find(params[:id])
    if entity.update(psi_update_params)
      render json: entity, status: :ok
    else
      render json: entity.errors, status: :unprocessable_entity
    end
  end

  def psi_register_params
    params.require(:psi).permit(:cnpj, :crp, :image, :user_id)
  end

  def psi_update_params
    params.require(:psi).permit(:cnpj, :crp, :image)
  end
end
