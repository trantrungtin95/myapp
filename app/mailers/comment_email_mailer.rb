class CommentEmailMailer < ApplicationMailer
    default :form =>  "Book Store <trantrungtinbkit@gmail.com>"

    def send_email_to_reviewer(comment)
        @commentator = comment.user
        @user = comment.review.user
        mail(to: @user.email , subject: "#{@commentator.name} has a new comment ")
    end
end
