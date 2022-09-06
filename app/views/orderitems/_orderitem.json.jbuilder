json.extract! orderitem, :id, :quantity, :unit, :total, :name, :description, :created_at, :updated_at
json.url orderitem_url(orderitem, format: :json)
