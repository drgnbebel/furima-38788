require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '出品登録できる場合' do
      it "登録項目が全て存在すれば出品登録できる" do
        expect(@item).to be_valid
      end
      it "カテゴリーが初期値(---)以外であれば出品登録できる" do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it "商品の状態が初期値(---)以外であれば出品登録できる" do
        @item.item_status_id = 2
        expect(@item).to be_valid
      end
      it "配送料の負担が初期値(---)以外であれば出品登録できる" do
        @item.shipping_cost_id = 2
        expect(@item).to be_valid
      end
      it "配送元の地域が初期値(---)以外であれば出品登録できる" do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it "発送までの日数が初期値(---)以外であれば出品登録できる" do
        @item.shipping_date_id = 2
        expect(@item).to be_valid
      end
      it "販売価格が半角数字で300円〜9,999,999円であれば出品登録できる" do
        @item.price ='300'
        expect(@item).to be_valid
      end
    end
    context '出品登録できない場合' do
      it 'ユーザーが紐付いていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it "商品画像が選択されないと出品登録できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が空では出品登録できない" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "商品の説明が空では出品登録できない" do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "カテゴリーが初期値(---)では出品登録できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "商品の詳細が初期値(---)では出品登録できない" do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status must be other than 1")
      end
      it '配送料の負担が初期値(---)では出品登録できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost must be other than 1")
      end
      it '発送元の地域が初期値(---)では出品登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '発送までの日数が初期値(---)では出品登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end
      it '販売価格が空では出品登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格に半角数字以外が含まれている場合は出品できない' do
        @item.price = "dollars"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '販売価格が300円未満では出品登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '販売価格が9,999,999円を超過すると出品登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end

