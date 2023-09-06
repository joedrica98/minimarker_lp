class ProductosController < ApplicationController
    skip_before_action :verify_authenticity_token

     # GET /productos
    def index
        if params[:nombre]
          @productos = Producto.where('nombre LIKE ?', "%#{params[:nombre]}%")
        else
          @productos = Producto.all
        end
        render json: @productos
      end
  
    # GET /productos/:id
    def show
      @producto = Producto.find(params[:id])
      render json: @producto
    end
    
    # POST /productos
    def create
      @producto = Producto.new(product_params)
      if @producto.save
        render json: @producto, status: :created
      else
        render json: @producto.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /productos/:id
    def update
      @producto = Producto.find(params[:id])
      if @producto.update(product_params)
        render json: @producto
      else
        render json: @producto.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /productos/:id
    def destroy
      @producto = Producto.find(params[:id])
      @producto.destroy
      render json: { message: "Producto eliminado exitosamente" }
    end


    def agregar_a_carrito
      producto_id = params[:producto_id]
      cantidad = params[:cantidad].to_i
      producto = Producto.find(producto_id)
      carrito = Carrito.first_or_initialize
    
      if carrito.new_record?
        carrito.save!
      end
    
      # Verifica si el producto ya está en el carrito
      carrito_producto = CarritoProducto.find_by(carrito: carrito, producto: producto)
    
      if producto.stock < cantidad
        render json: { message: "Stock insuficiente" }, status: :unprocessable_entity
      elsif carrito_producto
        # Si el producto ya está en el carrito, actualiza la cantidad
        nueva_cantidad = carrito_producto.cantidad + cantidad
        carrito_producto.update!(cantidad: nueva_cantidad)
        render json: { message: "Cantidad actualizada en el carrito" }
      else
        # Si el producto no está en el carrito, lo agrega
        CarritoProducto.create!(carrito: carrito, producto: producto, cantidad: cantidad)
        render json: { message: "Producto agregado al carrito" }
      end
    end
    
    def ver_carrito
      carrito = Carrito.first
      if carrito
        total = 0.0
        productos_en_carrito = carrito.productos.map do |producto|
          cantidad = CarritoProducto.find_by(carrito: carrito, producto: producto).cantidad
          precio = producto.precio
          subtotal = cantidad * precio
          total += subtotal

          {
            nombre: producto.nombre,
            descripcion: producto.descripcion,
            precio: precio,
            cantidad: cantidad,
            subtotal: subtotal.round(2)
          }
        end

        render json: { items: productos_en_carrito, total: total.round(2) }
      else
        render json: { message: "Carrito vacío" }
      end
    end

  
    def finalizar_compra
      carrito = Carrito.first
  
      if carrito
        carrito.carrito_productos.each do |item|
          producto = item.producto
          producto.update!(stock: producto.stock - item.cantidad)
        end
  
        CarritoProducto.where(carrito: carrito).delete_all
        render json: { message: "Compra finalizada exitosamente" }
      else
        render json: { message: "Carrito vacío" }
      end
    end
  
    private
    def product_params
      params.require(:producto).permit(:nombre, :descripcion, :precio, :stock, :image_url)
    end
    
  end
  
