class CommandsController < ApplicationController
  def index
    @commands = Command.all
  end

  def create
    @command = Command.new name: params[:name], arguments: params[:arguments]
    @command.save
  end
end
