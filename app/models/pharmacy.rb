class Pharmacy < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :auto_accept, -> { where(auto_accept_orders: true) }

  def accepts_orders?
    active? && auto_accept_orders?
  end
end
