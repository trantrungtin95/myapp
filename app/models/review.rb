class Review < ApplicationRecord
    after_create :send_email_to_follower
    has_many :likes
    has_many :comments
    belongs_to :user

    def self.total
        # only call on Review (class)
    end

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

    def root_comments
        comments.where(comment_id: nil)
    end
private
    def send_email_to_follower
        NotificationMailer.send_email(self).deliver
      end
    
end
