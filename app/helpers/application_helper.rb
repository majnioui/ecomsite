module ApplicationHelper
  def current_order
    if current_user
      exist_cart = Order.find_by(user_id: current_user.id, status: "cart")
      if exist_cart.nil?
        Order.new(user_id: current_user.id, status: "cart")
      else
        exist_cart
      end
    end
  end
end
