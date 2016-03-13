Rails.application.routes.draw do
  resources :departamentos
  resources :produtos, only: [:new, :create, :destroy, :edit, :update]
  root "produtos#index"
  get "/produtos/busca" => "produtos#busca" , as: :busca_produto
  


end
