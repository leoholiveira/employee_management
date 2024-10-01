class SyncEmployeesJob < ApplicationJob
  queue_as :default

  def perform
    SyncEmployeesOperation.call
  end
end
