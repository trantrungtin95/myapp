class Following < ApplicationRecord
    belongs_to :user
    # class methods vs instance/object methods
    belongs_to :follower, class_name: User.name, foreign_key: :follower_id

    def self.new_class_method
        # only call on class
    end

    def new_instance_method
        # only call on instance
    end


end
