require 'digest/sha2'

class User < ApplicationRecord
    has_many :reviews
    has_many :comments
    has_many :bookcases
    has_many :followings
    has_many :products
    has_many :privates
    has_many :visiteds
    has_many :last_pages
    has_many :bookmarks
    has_one_attached :avatar
    validates :name, :presence => true, :uniqueness => true
    validates :password, :confirmation => true
    attr_accessor :password_confirmation
    attr_reader :password
  
    validate :password_must_be_present

    DEFAULT_NAME = 'Robert'

    
  
    def User.encrypt_password(password, salt) 
        Digest::SHA2.hexdigest(password + salt)
    end
  
    def password=(password) 
        @password = password
  
        if password.present?
            generate_salt
            self.hashed_password = self.class.encrypt_password(password, salt)
        end
    end
  
    def User.authenticate(name, password) 
        if user = find_by_name(name)
            if user.hashed_password == encrypt_password(password, user.salt)
               user
            end
        end
    end

    after_destroy :check_user_empty
  
    def check_user_empty
        if User.count.zero?
            raise "Can't delete last user"
        end
    end

    def followed?(other_user)
        Following.where(user_id: other_user.id, follower_id: id).exists?
    end

    def followers
        # TODO: improve performance when db gets bigger
        Following.where(user_id: id).map(&:follower)
    end
 
    private
    def password_must_be_present 
        if hashed_password.present? == false
            errors.add(:password, "Missing password")
        end
    end
  
    def generate_salt
        self.salt = self.object_id.to_s + rand.to_s
    end
end
