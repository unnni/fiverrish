class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    # TODO: Create a new order for the spcified user/service.
    # Redirect to an appropriate page if save fails.
  end

  def user_orders
    @orders = current_user.orders
  end

end
