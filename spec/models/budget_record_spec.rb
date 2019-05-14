require 'rails_helper'

RSpec.describe BudgetRecord, type: :model do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:record_type) }
  it { should validate_presence_of(:date_from) }
  it { should validate_presence_of(:date_to) }
  it { should validate_presence_of(:amount) }
end
