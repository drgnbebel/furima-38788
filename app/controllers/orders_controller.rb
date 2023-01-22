class OrdersController < ApplicationController
  before_action :no_set_item, only: [:index, :create]


  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_cord, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:free_id], token: params[:token])
  end

  def no_set_item
    @item = Item.find(params[:free_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end