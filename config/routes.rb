SupportMe::Application.routes.draw do

  root to: 'site#index', as: :home

  match 'signup' => 'users#signup', via: [ :get, :post ], as: :signup
  post 'login' => 'users#login', as: :login

  get 'dashboard' => 'site#dashboard', as: :dashboard

end
