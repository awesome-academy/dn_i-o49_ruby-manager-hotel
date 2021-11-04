Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root :to => "rooms#index"
    get :confirm, to: "rooms#confirm"
    resources :rooms, only: [:index, :show]
    get :login, to: "sessions#new"
    post :login, to: "sessions#create"
    delete :logout, to: "sessions#destroy"
    post :sessions_update, to: "sessions#update"
    resources :users, only: :show
    resources :bookings, only: %i(index create)

    namespace :admin do
        resources :bookings, only: :index
    end
  end
end
