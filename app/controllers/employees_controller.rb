class EmployeesController < ApplicationController
  def index
    @employees = SyncEmployeesOperation.call
    @employees = Employee.all.order(:last_name, :first_name)
  end
end
