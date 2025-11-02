Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dealers#index"
  resources :dealers do
    resources :users
    resources :vehicles
  end
  devise_scope :user do
    get  "dealers/:dealer_id/users/invitations/new",
         to: "users/invitations#new",   as: :new_dealer_users_invitation
    post "dealers/:dealer_id/users/invitations",
         to: "users/invitations#create", as: :dealer_users_invitations
  end
end
