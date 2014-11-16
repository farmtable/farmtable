class Api::CartsController < Api::ApiController
  include ListingsHelper
  before_filter :require_community

  def add
    # add item to session
    items = begin JSON.parse(session[:items]) rescue [] end
    items = items.push(params["item_id"])
    session[:items] = items.to_json
    render json: {"items" => session[:items]}
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
