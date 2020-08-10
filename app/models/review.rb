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

    # methods
    # Human: 
    #   attributes (data): name, age, eyes
    #   methods: eat, run, see, says

    # Product
    #   attributes: title: "Rails", page_number: 101, author: 'Dave'
    #  
    def users_like
        likes.map{|like| like.user.name }
    end
    
end
