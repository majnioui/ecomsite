class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    belongs_to :user
    has_rich_text :description
end
