class OrderStatus < ApplicationRecord
    has_many :orders

    # enum status: [:pending,:completed, :cancel]
    after_initialize :set_default_status, :if => :new_record?
  def set_default_status
    self.name ||= 'pending'
  end
end
