json.extract! bookcase, :id, :user_id, :title, :description, :image_url, :created_at, :updated_at
json.url bookcase_url(bookcase, format: :json)