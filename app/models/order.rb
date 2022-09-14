class Order < ApplicationRecord
    has_many :order_items
    belongs_to :user

    before_save :set_subtotal

    enum status: { cart: 0, ordered: 1, paid: 2}

    def subtotal # return total amount of an order (includs many itmes total)
      order_items.collect { |order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0 }.sum
    end

    def count_subitems # return number of items in an order
      order_items.collect { |order_item| order_item.valid? ? order_item.quantity : 0 }.sum
    end


    private

    def set_subtotal
      self[:subtotal] = subtotal
    end
  end