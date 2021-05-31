require 'rails_helper'

RSpec.describe DonationAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    @donation_address = FactoryBot.build(:donation_address, user_id: user.id)
  end

  describe '新規に寄付を行う' do
    context '寄付ができる場合' do
      it 'すべての入力項目が正しく入力されていれば寄付ができる' do
        expect(@donation_address).to be_valid
      end

      it 'cityは空でも寄付できる' do
        @donation_address.city = ''
        expect(@donation_address).to be_valid
      end

      it 'house_numberは空でも寄付できる' do
        @donation_address.house_number = ''
        expect(@donation_address).to be_valid
      end

      it 'building_nameは空でも寄付ができる' do
        @donation_address.building_name = ''
        expect(@donation_address).to be_valid
      end

    end

    context '寄付ができない場合' do
      it 'priceが空では寄付できない' do
        @donation_address.price = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字では寄付できない' do
        @donation_address.price = '１０'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Price is valid")
      end

      it 'priceが1未満では寄付できない' do
        @donation_address.price = 0
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Price is valid")
      end

      it 'priceが1000001以上では寄付できない' do
        @donation_address.price = 1000001
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Price is valid")
      end

      it 'postal_codeが空では寄付できない' do
        @donation_address.postal_code = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeがハイフンなしでは寄付できない' do
        @donation_address.postal_code = '1234567'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'user_idが紐づいていないと寄付できない' do
        @donation_address.user_id = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("User can't be blank")
      end

      it 'prefectureが選択されていないと寄付できない' do
        @donation_address.prefecture = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Prefecture can't be blank")
      end
    end
  end
end
