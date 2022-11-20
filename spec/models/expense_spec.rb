require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :each do
    @user = User.new(name: 'adio', email: 'adio@email.com', password: '123456t')
    @category = Group.new(name: 'Food', user_id: @user.id,
                          icon: Rack::Test::UploadedFile.new('spec/support/test_image.jpg'))
    @expense = Expense.new(name: 'Pizza', group_id: @category.id, user_id: @user.id)
  end

  before { subject.save }

  it 'name must not be blank.' do
    @expense.name = nil
    expect(@category).to_not be_valid
  end

  it 'amount unit must not be blank.' do
    @expense.amount = nil
    expect(@category).to_not be_valid
  end

  it 'amount unit must not be blank.' do
    @expense.name = ''
    expect(@category).to_not be_valid
  end

  it 'amount unit must not be blank.' do
    @expense.amount = ''
    expect(@category).to_not be_valid
  end
end
