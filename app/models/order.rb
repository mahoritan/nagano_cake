class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum select_address: { home_address: 0, registered_address: 1, new_address: 2 }

  validates :address, presence: true
  validates :postal_code, presence: true
  validates :name, presence: true

end
