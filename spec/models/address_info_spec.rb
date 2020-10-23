require 'rails_helper'

RSpec.describe AddressInfo, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @address_info = FactoryBot.build(:address_info, user_id: user.id, item_id: item.id)
      sleep(2)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@address_info).to be_valid
    end
    it 'zip_codeが空だと保存できないこと' do
      @address_info.zip_code = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Zip code can't be blank")
    end
    it 'zip_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @address_info.zip_code = '1234567'
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
    end
    it 'prefectures_idを選択していないと保存できないこと' do
      @address_info.prefectures_id = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Prefectures can't be blank", 'Prefectures is not a number')
    end
    it 'prefectures_idが１だと保存できないこと' do
      @address_info.prefectures_id = 1
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Prefectures must be other than 1")
    end
    it 'cityは空だと保存できないこと' do
      @address_info.city = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("City can't be blank", "City is invalid")
    end
    it 'street_numberは空だと保存できないこと' do
      @address_info.street_number = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Street number can't be blank")
    end
    it 'buildingは空でも保存できること' do
      @address_info.building = nil
      expect(@address_info).to be_valid
    end
    it 'phone_numberが空だと保存できないこと' do
      @address_info.phone_number = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberにハイフンが含まれていると保存できないこと' do
      @address_info.phone_number = "090-1234-5678"
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Phone number is invalid")
    end
    it 'tokenが空だと保存できないこと' do
      @address_info.token = nil
      @address_info.valid?
      expect(@address_info.errors.full_messages).to include("Token can't be blank")
   
    end
  end
end
