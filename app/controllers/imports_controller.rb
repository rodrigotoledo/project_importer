class ImportsController < ApplicationController
  def index
    imports = Import.includes(:products)
    result = {
      product_list: group_products_by_category(imports),
      category_weights: calculate_category_weights(imports),
      weighing_start_date: imports.first&.created_at
    }

    render json: result
  end

  def create
    import = Import.new(file: params[:file])

    if import.save
      import.create_products_from_file
      render json: import, status: :created
    else
      render json: import.errors, status: :unprocessable_entity
    end
  end

  private

  def group_products_by_category(imports)
    imports.each_with_object({}) do |import, result|
      import.products.each do |product|
        category = product.category
        result[category] ||= []
        result[category] << product
      end
    end
  end

  def calculate_category_weights(imports)
    imports.each_with_object({}) do |import, result|
      import.products.each do |product|
        category = product.category
        result[category] ||= 0
        result[category] += product.weight.to_f
      end
    end
  end
end
