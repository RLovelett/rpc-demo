class Command < ActiveRecord::Base
  after_create :async_run_command
  attr_accessible :arguments, :name

  private
  def async_run_command
    job = RunCommand.enqueue(self.id)
    self.resque_id = job.meta_id
    self.save
  end
end
