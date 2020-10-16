class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :price, presence: true
  validates :postage_id, presence: true
  validates :region_id, presence: true
  validates :shipping_date_id, presence: true
  validates :image, presence: true
  
end
