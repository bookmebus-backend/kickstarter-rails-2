class Order < ApplicationRecord
  enum status: { pending: 0, completed: 1, cancel: 2 }
  
  belongs_to :user
  has_many :order_items, dependent: :destroy

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= :pending
  end
end
