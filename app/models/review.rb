class Review < ApplicationRecord
    belongs_to :product
    has_many :likes

    def like_count
        likes.count #
    end
end
