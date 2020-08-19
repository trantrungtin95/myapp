class Comment < ApplicationRecord
  before_create :set_level
  after_create :email_comment
    

    belongs_to :review
    belongs_to :comment, optional: true  #--> new column: comment_id
    belongs_to :user
    


    def children_comments
      Comment.where(comment_id: self.id)
    end

    # class methods
    def self.set_existing_comment_level
      Comment.where(level: 0).find_each do |comment|
        # set correct level
        comment.level = calculate_level(comment)
        comment.save
      end
    end

    def self.calculate_level(comment)
      if comment.comment_id.nil?
        0
      else
        1 + calculate_level(comment.comment)
      end
    end

    private
    def email_comment
      CommentEmailMailer.send_email_to_reviewer(self).deliver
    end

    def set_level
      # if parent is nil, level = 0
      # else  level = parent comment's lelve + 1
      if comment_id.present?
        self.level = comment.level + 1
      end
    end
end
