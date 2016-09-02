Rails.application.routes.draw do
  root 'home#index'
  get 'online_lending/login' => 'home#login'
  get 'online_lending/register' => 'home#register'
  post 'online_lending/login_user' => 'home#login_user'
  delete 'online_lending/logout' => 'home#logout'

  post 'online_lending/lender/create_user' => 'lenders#create_user', as: :lender_create
  get 'online_lending/lender/:id' => 'lenders#show', as: :lender_show

  post 'online_lending/borrower/create_user' => 'borrowers#create_user', as: :borrower_create
  get 'online_lending/borrower/:id' => 'borrowers#show', as: :borrower_show

  post '/lend' => 'lenders#lend'



end
