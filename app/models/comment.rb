class Comment < ApplicationRecord
    after_create :email_comment
    belongs_to :review
    belongs_to :comment, optional: true  #--> new column: comment_id
    belongs_to :user


    def children_comments
      Comment.where(comment_id: self.id)
    end

    private
    def email_comment
        CommentEmailMailer.send_email_to_reviewer(self).deliver
      end

end
