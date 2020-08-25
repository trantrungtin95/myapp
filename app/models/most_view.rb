class MostView < ApplicationRecord
    belongs_to :product

    KINDS = [:day, :week, :month] # values of kind column
end
