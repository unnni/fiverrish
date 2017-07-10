class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:new, :create]

  def new
    @orders = @service.orders.build
  end

  def create
    # TODO: Create a new order for the spcified user/service.
    # Redirect to an appropriate page if save fails.
    
    @orders = @service.orders.create(order_params)
    @orders.total_price = (@orders.price)*(@orders.quantity)
    #render plain: @orders.inspect
    @orders.save
    redirect_to order_path(@orders)
    #respond_to do |format|
    #  if @orders.save
    #    format.html {redirect_to order_path(@orders), notice: "Order placed successfully!"}
    #    format.json {render :show, status: :created, location: @order }
    #  else
    #    format.html {render :new}
    #    format.json {render json: @orders.errors, status: :unprocessable_entity}
    #  end
    #end
  end

  def show
    @orders = Order.find(params[:id])
  end

  def user_orders
    @orders = current_user.orders
  end

  private

    def set_service
      @service = Service.find(params[:service_id])
    end

  	def order_params
  		params.require(:order).permit(:id ,:service_id, :price, :quantity, :user_id)
  	end
end
