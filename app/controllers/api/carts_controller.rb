class Api::CartsController < Api::ApiController
  include ListingsHelper
  before_filter :require_community

  respond_to :html, :xml, :json, :pdf

  def add
    # add item to session
    item_id = params["item_id"]
    req_quant = params["req_quant"]
    item = Listing.find_by_id(item_id)
    @current_user.current_cart.add(item_id, item.price, req_quant)
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

  def invoice
    Payday::Config.default.company_name = "FARMTABLE"
    invoice = Payday::Invoice.new(:invoice_number => @current_user.current_cart.id)
    @current_user.current_cart.cart_items.each do |row|
      listing = Listing.find_by_id(row.item_id)
      invoice.line_items << Payday::LineItem.new(:price => listing.price, :quantity => row.quantity, :description => listing.title)
    end
    respond_to do |format|
      format.html
      format.pdf do
        send_data invoice.render_pdf, :filename => "Invoice #12.pdf", :type => "application/pdf", :disposition => "inline"
      end
    end
  end

end
