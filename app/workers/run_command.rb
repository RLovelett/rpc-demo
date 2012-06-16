require 'resque-meta'

class RunCommand
  extend Resque::Plugins::Meta

  @queue = :rpc

  def self.perform(meta_id, command_id)
    Command.find(command_id)
  end
end
