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

end
