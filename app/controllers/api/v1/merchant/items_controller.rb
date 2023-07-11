class Api::V1::Merchant::ItemsController < ApplicationController
  def index 
    render json: ItemSerializer.new(Item.all)
  end
end