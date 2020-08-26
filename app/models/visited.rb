class Visited < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :ordered, -> { order('created_at desc') }
end
