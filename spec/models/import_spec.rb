require 'rails_helper'

RSpec.describe Import, type: :model do
  describe "create_products_from_file" do
    let(:import) { Import.new }

    context "when a file is attached" do
      let(:csv_file) { Rails.root.join("spec/support/products.csv") }
      let(:csv_blob) { fixture_file_upload(csv_file, "text/csv") }

      it "creates products from attached CSV file" do
        import.file.attach(csv_blob)
        import.save!

        expect {
          import.create_products_from_file
        }.to change(Product, :count).by(6)
      end
    end

    context "when no file is attached" do
      it "does not create any products" do
        expect {
          import.create_products_from_file
        }.not_to change(Product, :count)
      end
    end
  end
end
