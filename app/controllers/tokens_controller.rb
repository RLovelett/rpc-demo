class TokensController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def create
    @user = current_user
    @user.reset_authentication_token!
  end

  def destroy
    @user = current_user
    @user.reset_authentication_token!
  end
end
