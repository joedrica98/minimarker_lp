class ProductosController < ApplicationController
    skip_before_action :verify_authenticity_token
  
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
  
    private
    def product_params
      params.require(:producto).permit(:nombre, :descripcion, :precio, :stock)
    end
  end
  