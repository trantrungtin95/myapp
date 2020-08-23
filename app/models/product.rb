class Product < ActiveRecord::Base
    has_many :reviews
    # attr_reader, attr_writer:
    has_one_attached :cover
    has_one_attached :pdf
    has_many :luotxem
    has_many :favorites
    belongs_to :user
    # attr_reader :user_id
    # attr_writer :user_id
    validates :title, :description, :image_url, :presence => true
    validates :price, :numericality =>{:greater_than_or_equal_to => 1.0}
    validates :title, :uniqueness => true
    # validates :image_url, :format =>{
    #     :with => %r{\.(gif|jpg|png|jpeg)\Z}i,
    #     :message => 'Chi nhan file GIF, JPG, PNG, JPEG'
    # }

    has_many :line_items
    before_destroy :check_if_has_line_item

    scope :find_title, ->(search){where "title iLIKE ?", "%#{search}%"}
    # Ex:- scope :active, -> {where(:active => true)}

    # def luotxem
    #     @product.luotxem.create(user_id: current_user.id)
    #     redirect_to product_path(@product)
    # end

    def favorite_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def private_by?(user)
        Private.where(product_id: self.id, user_id: user.id).exists?
    end
    

    
  
     private
  
    def check_if_has_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'This product has a LineItem')
            return false
        end
    end
end
