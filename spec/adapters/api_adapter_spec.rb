require 'rails_helper'

RSpec.describe ApiAdapter do
  let(:adapter) { described_class.new }

  describe '#fetch_token' do
    it 'returns an access token' do
      VCR.use_cassette('api_token') do
        token = adapter.send(:fetch_token)
        expect(token).to be_a(String)
        expect(token).not_to be_empty
      end
    end
  end

  describe '#fetch_employees' do
    it 'returns an array of employee data' do
      VCR.use_cassette('employee_list') do
        employees = adapter.fetch_employees
        expect(employees).to be_an(Array)
        expect(employees.first).to include('id', 'first_name', 'last_name', 'email')
      end
    end

    it 'handles API errors gracefully' do
      allow(described_class).to receive(:get).and_raise(HTTParty::Error)
      expect { adapter.fetch_employees }.to raise_error(HTTParty::Error)
    end
  end
end
