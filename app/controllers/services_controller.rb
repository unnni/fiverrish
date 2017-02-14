class ServicesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_service, only: [:show, :edit, :update]
  def index
    @services = current_user.services
  end

  def show
  end

  def new
    @service = current_user.services.build
  end

  def create
    # TODO: Save the newly created service. Redirect to an appropriate page if save fails.
  end

  def edit
  end

  def update
    # TODO: Save the updated service. Redirect to an appropriate page if save fails.
  end

  private
  def set_service
    @service = Service.find(params[:id])
  end
end
