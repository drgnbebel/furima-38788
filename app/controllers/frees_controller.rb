class FreesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:edit, :destroy]
  
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if set_user
    else
      redirect_to root_path
    end
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to free_path(item_params)
    else
      render :edit
    end
  end

  def destroy
    if set_user
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

 private

 def item_params
  params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
 end

 def set_item
  @item = Item.find(params[:id])
 end

 def set_user
  @item.user_id == current_user.id
 end
end
