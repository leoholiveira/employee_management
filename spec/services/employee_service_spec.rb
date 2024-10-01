require 'rails_helper'

RSpec.describe EmployeeService do
  let(:adapter) { instance_double(ApiAdapter) }
  let(:service) { described_class.new(adapter) }

  describe '#sync_employees' do
    let(:employee_data) do
      [
        { 'first_name' => 'John', 'last_name' => 'Doe', 'email' => 'john@example.com' },
        { 'first_name' => 'Jane', 'last_name' => 'Smith', 'email' => 'jane@example.com' }
      ]
    end

    before do
      allow(adapter).to receive(:fetch_employees).and_return(employee_data)
    end

    it 'creates new employees when they do not exist' do
      expect { service.sync_employees }.to change { Employee.count }.by(2)
    end

    it 'updates existing employees' do
      response = Employee.create!(first_name: 'Johnny', last_name: 'Doe', email: 'johnny@example.com')
      service.sync_employees
      expect(response.first_name).to eq('Johnny')
    end

    it 'handles empty response from API' do
      allow(adapter).to receive(:fetch_employees).and_return([])
      expect { service.sync_employees }.not_to change { Employee.count }
    end
  end

  describe '#list_employees' do
    before do
      Employee.create!(id: '1', first_name: 'John', last_name: 'Doe', email: 'john@example.com')
      Employee.create!(id: '2', first_name: 'Jane', last_name: 'Smith', email: 'jane@example.com')
    end

    it 'returns all employees' do
      employees = service.list_employees
      expect(employees.count).to eq(2)
      expect(employees.map(&:first_name)).to contain_exactly('John', 'Jane')
    end
  end
end
