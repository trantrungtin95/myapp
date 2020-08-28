class Newbook < ApplicationRecord
    belongs_to :product
    # should be class method 
    def self.mail_about_newbooks
        NewbookmailerMailer.send_mail_about_newbooks.deliver
        # Newbook.destroy_all
    end
end
