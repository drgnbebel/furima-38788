class Item < ApplicationRecord
  belongs_to :user
  #has_one    :order
  has_one_attached :image
end

private

def item_params
  params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
end
