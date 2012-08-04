require 'open_food_web/split_products_by_distributor'

Spree::HomeController.class_eval do
  include Spree::DistributorsHelper
  include OpenFoodWeb::SplitProductsByDistributor

  respond_override :index => { :html => { :success => lambda {
        product_ids = @products.map { |p| p.id }
        puts "Home controller index. Products: #{product_ids.inspect}."

        @products, @products_local, @products_remote = split_products_by_distributor @products, current_distributor
      } } }
end
