class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    belongs_to :user
    has_rich_text :description
    has_and_belongs_to_many :categories


    def has_categories?
        categories.length > 0
      end
end
