class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    belongs_to :user
    has_many :order_items
    has_rich_text :description
    has_and_belongs_to_many :categories
    has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record
    belongs_to :buyer, class_name: 'User'
    validates_presence_of :price, :name, :stock

    def has_categories?
        categories.length > 0
      end
end
