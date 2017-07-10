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
    @service = current_user.services.create(service_params)
    respond_to do |format|
      if @service.save
        format.html {redirect_to service_path(@service), notice: "Gig created successfully!"}
        format.json {render :show, status: :created, location: @service }
      else
        format.html {render :new}
        format.json {render json: @service.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    # TODO: Save the updated service. Redirect to an appropriate page if save fails.
  end

  def all_services
    @service = Service.all
  end

  private
  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit( :title, :description, :price, :requirements, :image)
  end
end
