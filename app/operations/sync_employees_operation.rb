class SyncEmployeesOperation
  def self.call
    new.call
  end

  def call
    Rails.cache.fetch("employees", expires_in: 1.hour) do
      EmployeeService.new.sync_employees
      Employee.all.to_a
    end
  end
end
