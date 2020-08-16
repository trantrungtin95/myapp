class Bookcase < ApplicationRecord
    belongs_to :user
    validates :title, :description, :image_url, :presence => true
    validates :title, :uniqueness => true
end
