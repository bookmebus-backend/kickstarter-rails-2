class OrderStatus < ApplicationRecord
    has_many :orders
    enum name: { pending: 0, completed: 1, cancel: 2 }
        after_initialize :set_default_status, :if => :new_record?
    def set_default_status
        self.name ||= :pending
    end
end
