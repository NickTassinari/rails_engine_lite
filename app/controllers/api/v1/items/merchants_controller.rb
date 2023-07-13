module Api 
  module V1 
    module Items 
      class MerchantsController < ApplicationController
        def show 
          render json: MerchantSerializer.new(Merchant.find(params[:id]))
        end
      end
    end
  end
end