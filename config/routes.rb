Rails.application.routes.draw do

  root to: 'home#index'
  post '/contact_us', to: 'home#contact_us'

  post '/webhooks/driver_sms', to: 'twilio_webhooks#driver_sms'

  resource :users, only: [:create]

  namespace :admin do
    root "home#index"
    resources :users do
      collection do
        get :active
        get :paused
        get :inactive
        post :mass_text
      end
    end
  end

end
