module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authorized, only: [:create, :index]

      def index
        render json: User.all
      end

      def create
        @user = User.create(user_params)
        if @user.valid?
          @token = encode_token(user_id: @user.id)
          render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
        else
          render json: { error: 'failed to create user' }, status: :not_acceptable
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :password, :house_id)
      end
    end

  end
end
