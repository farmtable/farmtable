class Api::CartsController < Api::ApiController
  include ListingsHelper
  before_filter :require_community

  def add
    # add item to session
    item_id = params["item_id"]
    item = Listing.find_by_id(item_id)
    @current_user.current_cart.add(item, item.price)
    render json: {"items" => @current_user.cart.cart_items}
  end

  def purchase
    current_cart = @current_user.current_cart
    # do something like invoice
    current_cart.status = 1
    current_cart.save
    cart = Cart.create
    cart.person_id = @current_user.id
    cart.save
    render json: {"items" => @current_user.current_cart.cart_items}
  end

end
