class Blog < ApplicationRecord
  has_rich_text :body

  extend FriendlyId
  friendly_id :title, use: :slugged

end
