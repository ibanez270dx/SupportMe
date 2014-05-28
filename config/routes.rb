SupportMe::Application.routes.draw do

  root to: 'site#index', as: :home

  match 'signup' => 'users#signup', via: [ :get, :post ], as: :signup
  post 'login' => 'users#login', as: :login
  get 'logout' => 'users#logout', as: :logout
  get 'user/anonymity' => 'users#toggle_anonymity', as: :user_anonymity

  get 'dashboard' => 'site#dashboard', as: :dashboard

end
