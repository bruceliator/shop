class ApplicationController < ActionController::Base
  before_action :set_locale
  protect_from_forgery with: :exception

  def default_url_options(options={})
    { locale: I18n.locale }.merge options
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def change_locale
    set_locale
    redirect_to root_url
  end

  private

  def current_order
    @current_order ||= begin
      if has_order?
        @current_order
      else
        order = Shoppe::Order.create(:ip_address => request.ip)
        session[:order_id] = order.id
        order
      end
    end
  end

  def has_order?
    !!(
    session[:order_id] &&
        @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
    )
  end

  helper_method :current_order, :has_order?
end
