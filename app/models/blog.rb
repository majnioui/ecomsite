class Blog < ApplicationRecord
  has_rich_text :body

  extend FriendlyId
  friendly_id :title, use: :slugged


  has_one :action_text_rich_text, class_name: 'ActionText::RichText', as: :record


end
