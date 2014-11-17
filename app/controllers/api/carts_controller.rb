class Api::CartsController < Api::ApiController
  include ListingsHelper
  before_filter :require_community

  def add
    # add item to session
    item_id = params["item_id"]
    item = Listing.find_by_id(item_id)
    @current_user.cart.add(item, item.price)
    render json: {"items" => @current_user.cart.cart_items}
  end

  def purchase
    items = begin JSON.parse(session[:items]) rescue [] end
    unless items.empty?
      c = @current_user.cart
      c.items = items
      c.person_id = nil
      c.save
      cart = Cart.create
      cart.person_id = @current_user.id
      cart.save
      session[:items] = ""
    end
    render json: {"status" => 200}
  end

end
