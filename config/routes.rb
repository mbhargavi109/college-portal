Rails.application.routes.draw do
  get "students/dashboard"
  get "teachers/dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  devise_for :users, controllers: { registrations: 'users/registrations' }, sign_out_via: [:delete, :get]
  get 'teachers/dashboard', to: 'teachers#dashboard'
  get 'students/dashboard', to: 'students#dashboard'

  resources :notes do
    member do
      delete :delete_file
      get :edit
      patch :update
      put :update
    end
  end


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
