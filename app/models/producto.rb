class Producto < ApplicationRecord
    has_many :carrito_productos
    has_many :carritos, through: :carrito_productos
  end