require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test " Thuoc tinh khong duoc de trong" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  test "Price phai lon hon 1.0" do
    product = Product.new(:title => 'Hmm...',
                          :description => 'Err...',
                          :image_url => 'Something.jpg')
    product.price = -1
    assert product.invalid? 
    assert_equal "must be greater than or equal to 1.0",
                 product.errors[:price].join('') 

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 1.0",
                 product.errors[:price].join('')

    product.price = 5
    assert product.valid?

end
   def new_product(image_url)
    Product.new(:title => 'Hmm...',
                :description => 'Err...',
                :image_url => image_url,
                :price => 5)
              end

test "image url" do
    url_hop_le = %w{ img.gif img.jpg img.png img.jpeg IMG.JPG IMG.Jpg http://a.b.c/x/y/z/img.gif }
    url_khong_hop_le = %w{ img.doc img.gif/more img.gif.more }

    url_hop_le.each do |name|
        assert new_product(name).valid?, "#{name} phai hop le"
    end

    url_khong_hop_le.each do |name|
        assert new_product(name).invalid?, "#{name} khong hop le"
    end
   end
   fixtures :products
  
    test "title khong duoc trung" do
        product = Product.new(:title => products(:ruby).title,
            :description => "Hmm...",
            :image_url => "img.jpg",
            :price => 5)
        assert !product.save
        assert_equal "has already been taken",
                     product.errors[:title].join('')
     end
end