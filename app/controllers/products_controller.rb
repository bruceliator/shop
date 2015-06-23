class ProductsController < ApplicationController
  def index
    @products = Shoppe::Product.root.ordered.includes(:product_categories, :variants)
    @products = @products.group_by(&:product_category)
  end

  def show
    @product = Shoppe::Product.joins(:translations).find_by_permalink(params[:permalink])
  end

  def buy
    @product = Shoppe::Product.joins(:translations).find_by_permalink!(params[:permalink])
    current_order.order_items.add_item(@product, 1)
    flash[:success] = t('flash.item_added')
    redirect_to product_path(@product.permalink)
  end
end
