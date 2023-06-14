require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "associations" do
    it { should belong_to(:import) }
  end

  describe "validations" do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:weight) }
  end
end