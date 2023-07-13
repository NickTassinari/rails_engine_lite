module Api 
  module V1 
    class ItemsController < ApplicationController
      # rescue_from ActiveRecord::RecordNotFound, with: :error_response

      def index 
        render json: ItemSerializer.new(Item.all)
      end

      def show 
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      def create 
        render json: ItemSerializer.new(Item.create!(item_params)), status: 201
      end

      # def update 
      #   begin
      #     render json: ItemSerializer.new(Item.update(params[:id], item_params))
      #   rescue StandardError => error 
      #     render json: ErrorSerializer.new(error).serialize_json, status: 404 
      #   rescue AssertionError => assertion_error 
      #     raise unless [400, 404].include?(error.response_code)
      #     render json: ErrorSerializer.new(error).serialize_json, status: 404 
      #   end
      # end
      def update
        item = Item.update(params[:id], item_params)
        if item.save
          render json: ItemSerializer.new(Item.update(params[:id], item_params))
        else
          render :status => 400
        end
      end

      def destroy 
        render json: ItemSerializer.new(Item.destroy(params[:id]))
      end

      private 

      def item_params 
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end

      # def error_response(error)
      #   render json: ErrorSerializer.new(error).serializer_json, status: 404
      # end
    end
  end 
end