SupportMe::Application.routes.draw do

  root to: 'site#index', as: :home

  get 'signup' => 'site#signup', as: :signup
  get 'dashboard' => 'site#dashboard', as: :dashboard

  resources :users

end
