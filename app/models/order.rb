class Order < ApplicationRecord
  belongs_to :user
  belongs_to :order_status
  has_many :order_items, dependent: :destroy

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.order_status ||= OrderStatus.find_or_create_by(name: 'pending')
  end
end
