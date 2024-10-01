class EmployeeService
  def initialize(adapter = ApiAdapter.new)
    @adapter = adapter
  end

  def sync_employees
    employees_data = @adapter.fetch_employees
    employees_data.each do |employee_data|
      Employee.find_or_initialize_by(id: employee_data["id"]).update!(employee_data)
    end
  end

  def list_employees
    Employee.all
  end
end
