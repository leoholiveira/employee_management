require 'rails_helper'

RSpec.describe 'Employees Integration', type: :feature do
  before do
    allow_any_instance_of(ApiAdapter).to receive(:fetch_employees).and_return([
      { 'first_name' => 'John', 'last_name' => 'Doe', 'email' => 'john@example.com' },
      { 'first_name' => 'Jane', 'last_name' => 'Smith', 'email' => 'jane@example.com' }
    ])
  end

  it 'displays a list of employees' do
    visit employees_path

    expect(page).to have_content('Employees')
    expect(page).to have_content('John Doe')
    expect(page).to have_content('Jane Smith')
  end

  it 'updates employee list when syncing' do
    Employee.create!(first_name: 'Johnny', last_name: 'Doe', email: 'johnny@example.com')

    visit employees_path

    expect(page).to have_content('John Doe')
    expect(page).to have_content('Johnny Doe')
  end
end
