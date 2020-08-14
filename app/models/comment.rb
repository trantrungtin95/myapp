class Comment < ApplicationRecord
    after_create :email_comment
    belongs_to :review
    belongs_to :user




    private
    def email_comment
        CommentEmailMailer.send_email_to_reviewer(self).deliver
      end

end
