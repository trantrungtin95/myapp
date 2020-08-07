class Review < ApplicationRecord
    belongs_to :product
    has_many :likes

    def like_count
        likes.count #
    end

    def like_by?(user)
        likes.where(user_id: user.id).exists?
    end
end
