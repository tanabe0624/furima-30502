class AddressInfo
  include ActiveModel::Model
  attr_accessor :zip_code, :prefectures_id, :city, :street_number, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefectures_id, numericality: { other_than: 1 }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
    validates :street_number
    validates :phone_number, format: {with: /\A\d{11}\z/}
    validates :token, presence: true
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    address = Address.create(zip_code: zip_code, prefectures_id: prefectures_id, city: city, street_number: street_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end
