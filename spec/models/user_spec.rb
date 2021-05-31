require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録ができる場合' do
      it 'すべての値が正しく入力されていれば新規登録ができる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない場合' do
      it 'nameが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it 'nameが半角文字だと登録できない' do
        @user.name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name is invalid. Input full-width characters.")
      end

      it 'name_readingが空だと登録できない' do
        @user.name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name reading can't be blank")
      end

      it 'name_readingが半角文字だと登録できない' do
        @user.name_reading = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
      end

      it 'name_readingが全角カナ以外の全角文字（ひらがな、漢字）だと登録できない' do
        @user.name_reading = '鈴木'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
      end

      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'nicknameが全角文字だと登録できない' do
        @user.nickname = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is invalid. Input harf-width characters.")
      end
    end
  end
end