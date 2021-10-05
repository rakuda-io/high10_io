module Api
  class UsersController < ApplicationController
    def index
      users = User.order(created_at: :desc)
    end

    def show
      user = User.find(params[:user_id])
      render json: user
    end

    def create
      user = User.
    end
  end
end