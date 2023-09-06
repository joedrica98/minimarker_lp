class AddImageUrlToProductos < ActiveRecord::Migration[7.0]
  def change
    add_column :productos, :image_url, :string
  end
end
