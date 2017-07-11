class ChargesController < ApplicationController
	before_action :set_order, only: [:create]

	def new
	end

	def create
	  # Amount in cents

	  @amount = @orders.total_price

	  customer = Stripe::Customer.create(
		    :email => params[:stripeEmail],
		    :source  => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => 'Rails Stripe customer',
		    :currency    => 'inr'
		  )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_charge_path
	 end

	 def show
	 end
	  

	private
		def set_order
      		@orders = Order.find(params[:id])
    	end

    	def order_params
  			params.require(:order).permit(:id ,:service_id, :price, :quantity, :user_id)
  		end
end
