class Product < ActiveRecord::Base
    has_many :reviews
    # attr_reader, attr_writer:
    has_one_attached :cover
    has_one_attached :pdf
    has_many :luotxem
    has_many :favorites
    has_many :visiteds
    has_many :last_pages
    has_many :bookmarks
    belongs_to :user, optional: true
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
    def visited_by?(user)
        visiteds.where(user_id: user.id).exists?
    end

    def favorite_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def private_by?(user)
        Private.where(product_id: self.id, user_id: user.id).exists?
    end
    
    def self.reset_day_views
        # TODO: 
        # Save the top 10 most views into the table. Rails: order(day_views)  & limit
        # Save into MostView model
        # Reset day views. 
        MostView.where(kind: :day).destroy_all
        products = Product.order('day_views desc').limit(10) # index 0 : most view
        products.each_with_index do |product, index|
            # save into MostView
            MostView.create(product_id: product.id, kind: :day, postion: index, day_views: product.day_views)
        end
        Product.update_all(day_views: 0) # sql
    end

    def self.reset_week_views
        MostView.where(kind: :week).destroy_all
        product = Product.order('week_views desc').limit(10)
        product.each_with_index do |product,index|
            MostView.create(product_id: product.id, kind: :week, postion: index, day_views: product.week_views)
        end
        Product.update_all(week_views: 0)
    end

    def self.reset_month_views
        MostView.where(kind: :month).destroy_all
        product = Product.order('month_views desc').limit(10)
        product.each_with_index do |product,index|
            MostView.create(product_id: product.id, kind: :month, postion: index, day_views: product.month_views)
        end
        Product.update_all(month_views: 0)
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
