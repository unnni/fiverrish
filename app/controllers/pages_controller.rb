class PagesController < ApplicationController
  def home
  	@services = Service.last(4).reverse
  end
end
