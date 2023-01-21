class OrdersController < ApplicationController

  def index
    @order_form = OrderForm.new
  end

  def create
  end
end
