# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_06_015806) do
  create_table "carrito_productos", force: :cascade do |t|
    t.integer "carrito_id", null: false
    t.integer "producto_id", null: false
    t.integer "cantidad"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrito_id"], name: "index_carrito_productos_on_carrito_id"
    t.index ["producto_id"], name: "index_carrito_productos_on_producto_id"
  end

  create_table "carritos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.decimal "precio"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  add_foreign_key "carrito_productos", "carritos"
  add_foreign_key "carrito_productos", "productos"
end
