Rails.application.routes.draw do

  root to: 'home#index'

  resource :users, only: [:create] do
  end

end
