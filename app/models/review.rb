class Review < ApplicationRecord
    belongs_to :product
    has_many :likes

    def like_count
        likes.count 
    end

    def like_by?(user)
        likes.where(user_id: user.id).exists?
    end

    def user_ids
        likes.map{|like|like.user_id}
    end
    
    def namelike
        user_ids.map{|i| User.find(i).name}
    end
    
end
