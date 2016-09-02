Rails.application.routes.draw do
  root 'home#index'
  get 'online_lending/login' => 'home#login'
  get 'online_lending/register' => 'home#register'

  get 'online_lending/lender/:id' => 'lender#show', as: :lender_show




end
