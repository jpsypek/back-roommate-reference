module Api
  module V1
    class HousesController < ApplicationController
      before_action :find_house, only: [:show]
      skip_before_action :authorized, only: [:index]

      def index
        render json: House.all
      end

      def show

        render json: @house
      end

      private

      def find_house
        @house = House.find(params[:id])
      end

    end
  end
end
