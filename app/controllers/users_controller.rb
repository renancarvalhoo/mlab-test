class UsersController < ApplicationController

  before_action :load_user, only: [:show, :companies, :company_groups]

  def index
    respond_with do |format|
      format.datatable do
        render json: UserDatatable.new(view_context)
      end
    end
  end

  def show
  end

  def create
    service = UserService.new(user_params)

    service.create

    if service.success
      @user = service.record

      render template: 'users/show', status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def update
    service = UserService.new(user_update_params)
    service.update(params[:id])

    if service.success
      @user = service.record

      render template: 'users/show', status: :ok
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    service = UserService.new

    service.destroy(params[:id])

    if service.success
      render nothing: true, status: :no_content
    else
      render json: { errors: service.errors }, status: :bad_request
    end
  end

  def batch_destroy
    service = UserService.new

    service.batch_destroy(params[:ids])

    if service.success
      render nothing: true, status: :no_content
    else
      render json: { errors: service.errors }, status: :bad_request
    end
  end

  private
    def user_params
      params.permit(:name, :email, :username, :password, :password_confirmation)
    end

    def user_update_params
      params.permit(:name, :email, :username)
    end
   
    def load_user
      
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: I18n.t('activemodel.errors.models.user.user_does_not_exist') }, status: :bad_request
      end
    end
end

