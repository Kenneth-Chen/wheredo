Rails.application.routes.draw do

  root to: 'home#index'
  post '/contact_us', to: 'home#contact_us'

  post '/webhooks/driver_sms', to: 'twilio_webhooks#driver_sms'

  resource :users, only: [:create]

  namespace :admin do
    root "home#index"

    devise_for :users, controllers: {sessions: "sessions"}

    get '/mass_send', to: 'sms#mass_send_new'
    post '/mass_send', to: 'sms#mass_send'
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
