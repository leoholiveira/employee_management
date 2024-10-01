require 'rails_helper'

RSpec.describe SyncEmployeesOperation do
  describe '.call' do
    it 'caches the result of syncing employees' do
      allow_any_instance_of(EmployeeService).to receive(:sync_employees)
      allow(Employee).to receive(:all).and_return([])

      expect(Rails.cache).to receive(:fetch).with('employees', expires_in: 1.hour)
      described_class.call
    end
  end
end
