
class DependentsController < ApplicationController
   before_action :authenticate_users!

  before_action :load_dependents, :only => [:show]

  def index
        respond_with do |format|
      format.json do
        if params[:user_id].present?
          @dependents = Dependent.where(user_id: params[:user_id] }).order(:id)
        else
          @dependents = Dependent.all
        end       
      end
      format.datatable do
        render json: DependentDatatable.new(view_context)
      end
    end
  end

  def show
  end

  def create
    service = DependentService.new(dependents_params)

    service.create

    if service.success
      @dependents = service.record

      render :template => "dependents/show", :status => :created
    else
      render :json => {:errors => service.errors}, :status => :unprocessable_entity
    end
  end

  def update
    service = DependentService.new(dependents_update_params)

    service.update(params[:id])

    if service.success
      @dependents = service.record

      render :template => "dependents/show", :status => :ok
    else
      render :json => {:errors => service.errors}, :status => :unprocessable_entity
    end
  end

  def destroy
    service = DependentService.new

    service.destroy(params[:id])

    if service.success
      render :nothing => true, :status => :no_content
    else
      render :json => {:errors => service.errors}, :status => :bad_request
    end
  end

  def batch_destroy
    service = DependentService.new

    service.batch_destroy(params[:ids])

    if service.success
      render :nothing => true, :status => :no_content
    else
      render :json => {:errors => service.errors}, :status => :bad_request
    end
  end

  private
  def dependents_params
    params.permit(:name, :parent, :users, :user_id)
  end

  def dependents_update_params
    params.permit(:name, :parent)
  end

  def load_dependents
    @dependents = Dependent.find(params[:id])
  end
end
