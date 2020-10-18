class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_date

  belongs_to :user
  has_one_attached :image
  
  validates :name, :description, :category_id, :condition_id, :price, :postage_id, :region_id, :shipping_date_id, :image, presence: true
  validates :category_id, :condition_id, :postage_id, :region_id, :shipping_date_id, numericality: { other_than: 1 }
  #このバリデーションは、各idのid:1以外のときに保存できるという意味

  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  VALID_PRICE_REGEX = /\A[\d]+\z/i
  validates :price, format: { with: VALID_PRICE_REGEX }

  
end

