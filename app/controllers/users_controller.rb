# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  email                  :string           default(""), not null
#  username               :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :load_user, :only => [:show]

  def index
    render json: UserDatatable.new(view_context)
  end

  def show
  end

  def create
    service = UserService.new(user_params)

    service.create

    if service.success
      @user = service.record

      render :template => "users/show", :status => :created
    else
      render :json => {:errors => service.errors}, :status => :unprocessable_entity
    end
  end

  def update
    service = UserService.new(user_update_params)

    service.update(params[:id])

    if service.success
      @user = service.record

      render :template => "users/show", :status => :ok
    else
      render :json => {:errors => service.errors}, :status => :unprocessable_entity
    end
  end

  def destroy
    service = UserService.new

    service.destroy(params[:id])

    if service.success
      render :nothing => true, :status => :no_content
    else
      render :json => {:errors => service.errors}, :status => :bad_request
    end
  end

  def batch_destroy
    service = UserService.new

    service.batch_destroy(params[:ids])

    if service.success
      render :nothing => true, :status => :no_content
    else
      render :json => {:errors => service.errors}, :status => :bad_request
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
    @user = User.find(params[:id])
  end
end