require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  describe 'GET #index' do
    let(:employees) do
      [
        Employee.create!(first_name: 'John', last_name: 'Doe'),
        Employee.create!(first_name: 'Jane', last_name: 'Smith')
      ]
    end

    before do
      allow(SyncEmployeesOperation).to receive(:call).and_return(employees)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @employees' do
      get :index
      expect(assigns(:employees)).to eq(employees)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
