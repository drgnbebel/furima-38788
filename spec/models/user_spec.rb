require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "登録項目が全て存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "パスワードが半角英数字6文字以上であれば登録できる" do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
      it "苗字が全角(漢字、ひらがな、カタカナ)であれば登録できる" do
        @user.last_name = '緒方'
        expect(@user).to be_valid
      end
      it "名前が全角(漢字、ひらがな、カタカナ)であれば登録できる" do
        @user.first_name = '光琳'
        expect(@user).to be_valid
      end
      it "苗字のフリガナが全角(カタカナ)であれば登録できる" do
        @user.last_name_kana ='オガタ'
        expect(@user).to be_valid
      end
      it "名前のフリガナが全角(カタカナ)であれば登録できる" do
        @user.first_name_kana ='コウリン'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "ニックネームが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスが重複すると登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it "メールアドレスは@を含まないと登録できない" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it "パスワードが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password Include both letters and numbers", "Password confirmation doesn't match Password")
      end
      it "パスワード(確認含む)が5文字以下では登録できない" do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワード(確認)が空では登録できない" do
        @user.password = 'abc123'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "苗字が全角(漢字、ひらがな、カタカナ)でないと登録できない" do
        @user.last_name = 'ogata'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it "名前が全角(漢字、ひらがな、カタカナ)でないと登録できない" do
        @user.first_name = 'kourin'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "苗字のフリガナが全角(カタカナ)でないと登録できない" do
        @user.last_name_kana = '緒方'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it "名前のフリガナが全角(カタカナ)でないと登録できない" do
        @user.first_name_kana = '光琳'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it "生年月日が空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
