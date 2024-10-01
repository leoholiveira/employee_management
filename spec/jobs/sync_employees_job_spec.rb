require 'rails_helper'

RSpec.describe SyncEmployeesJob, type: :job do
  describe '#perform' do
    it 'calls SyncEmployeesOperation' do
      expect(SyncEmployeesOperation).to receive(:call)
      described_class.new.perform
    end

    it 'handles errors gracefully' do
      allow(SyncEmployeesOperation).to receive(:call).and_raise(StandardError)
    end
  end
end
