class ChargesController < ApplicationController

	Stripe.api_key = ENV['stripe_api_key']
	def new
	end

	def create
	  # Amount in cents
	  @orders = Order.find(params[:order_id])
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
end
