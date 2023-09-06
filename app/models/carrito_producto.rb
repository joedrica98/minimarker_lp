class CarritoProducto < ApplicationRecord
  belongs_to :carrito
  belongs_to :producto
end