class OrderController < ApplicationController
    before_action :authenticate_user!
    before_action :require_buyer!, except: [:index]
  
    def create
      # TODO: add logic to handle case: empty cart
      
      if current_order.update(status: 'ordered')
        # session.delete(:order_id)
        flash[:notice] = "Order created successfully"
        redirect_to products_path
      else
        flash[:error] = "something wrong happened"
        redirect_to cart_path
      end
    end
  
    def index
      @orders = Order.where(user_id: current_user.id, status: 'ordered').order('created_at desc')
    end
end
