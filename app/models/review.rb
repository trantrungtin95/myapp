class Review < ApplicationRecord
    belongs_to :product
    has_many :likes
    has_many :comments

    def like_count
        likes.count 
    end

    def like_by?(user)
        likes.where(user_id: user.id).exists?
    end

    
    def users_like
        likes.map{|like| like.user.name }
    end
    
end
