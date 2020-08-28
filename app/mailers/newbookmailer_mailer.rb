class NewbookmailerMailer < ApplicationMailer
    default :form =>  "Book Store <trantrungtinbkit@gmail.com>"

    def send_mail_about_newbooks
        @products = Newbook.where(created_at: 7.days.ago..Date.today.end_of_day).map(&:product)
        @titles = @products.pluck(:title).join(',')
        User.all.find_each do |user|
            @user = user
            mail(to: @user.email , subject: "New books of the week")
        end
    end
end
