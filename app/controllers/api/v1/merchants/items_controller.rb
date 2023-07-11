class Api::V1::Merchants::ItemsController < ApplicationController
  before_action :merchant_search, only: [:index]
  
  def index 
    merchant_items = @merchant.items 
    render json: ItemSerializer.new(merchant_items)
  end

  private 
    def merchant_search
      @merchant = Merchant.find(params[:merchant_id].to_i)
    end
end