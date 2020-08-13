class NotificationMailer < ApplicationMailer
    default :from => "Book Store <trantrungtinbkit@gmail.com>"

  def send_email(review)
    @review = review
    @user = review.user
    @user.followers.each do |follower| 
      @followed_user = follower
      mail(to: @followed_user.email, subject: "#{@user.name} has a new review! ")
    end
  end

end