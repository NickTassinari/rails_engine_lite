module Api 
  module V1 
    class MerchantsController < ApplicationController 
      def index 
        render json: MerchantSerializer.new(Merchant.all)
      end
      
      def show 
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
      end

      private 
      def merchant_params 
        params.require(:merchant).permit(:name)
      end
    end
  end
end