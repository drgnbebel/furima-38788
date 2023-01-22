require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '配送先情報の保存' do
    context '配送先情報が保存できる場合' do
      it '保存項目が全て存在すれば保存できる' do
        expect(@order_form).to be_valid
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存できる' do
        @order_form.postal_cord = '123-4567'
        expect(@order_form).to be_valid
      end
      it '都道府県は、初期値(---)以外または、空でなければ保存できる' do
        @order_form.prefecture_id = 2
        expect(@order_form).to be_valid
      end
      it '市区町村は、空でなければ保存できる' do
        @order_form.city = '相生市'
        expect(@order_form).to be_valid
      end
      it '番地は、空でなければ保存できる' do
        @order_form.block = '桐生1-1'
        expect(@order_form).to be_valid
      end
      it '建物名は、空でも保存できる' do
        @order_form.building = nil
        expect(@order_form).to be_valid
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存できる' do
        @order_form.phone_number = 12_345_678_910
        expect(@order_form).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_form.user_id = 2
        expect(@order_form).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_form.item_id = 2
        expect(@order_form).to be_valid
      end
    end

    context '配送先情報が保存できない場合' do
      it '郵便番号が空だと保存できない' do
        @order_form.postal_cord = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal cord can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できない' do
        @order_form.postal_cord = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal cord is invalid. Include hyphen(-)')
      end
      it '都道府県が初期値(---)では保存できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できない' do
        @order_form.block = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できない' do
        @order_form.phone_number = '123 - 4567 - 8910'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が10桁以下だと保存できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できない' do
        @order_form.phone_number = '123456789101'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'user_idが空だと保存できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end