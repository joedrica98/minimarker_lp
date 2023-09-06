Rails.application.routes.draw do
  resources :productos
  
  get '/ver_carrito', to: 'productos#ver_carrito'
  post '/agregar_a_carrito', to: 'productos#agregar_a_carrito'
  post '/finalizar_compra', to: 'productos#finalizar_compra'
end
