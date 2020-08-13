class NotificationMailer < ApplicationMailer
    default :from => "trantrungtinbkit@gmail.com"
  def send_email(review)
    Following.where(user_id: review.user_id).each do |following| 
      @review = review
      @followed_user = User.find(following.follower_id)
      mail(to: @followed_user.email, subject: "#{User.find(review.user_id).name} has a new review! ")
    end
  end
end