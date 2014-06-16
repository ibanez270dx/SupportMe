SupportMe::Application.routes.draw do

  get '/' => 'site#index', as: :home

  match 'signup' => 'users#signup', via: [ :get, :post ], as: :signup
  post 'login' => 'users#login', as: :login
  get 'logout' => 'users#logout', as: :logout
  get 'user/anonymity' => 'users#toggle_anonymity', as: :user_anonymity

  post 'interest/add' => 'interests#add', as: :add_interest
  get 'interests' => 'interests#list', as: :interests

  get 'dashboard' => 'site#dashboard', as: :dashboard
  get 'support' => 'site#support', as: :support
  match 'connect' => 'site#connect', via: [ :get, :post ], as: :connect

  match 'callback' => 'site#callback', via: [ :get, :post ], as: :callback

  get 'verify/send' => 'users#send_verification', as: :send_verification
  get 'verify/:token' => 'users#receive_verification', as: :receive_verification
end
