Rails.application.routes.draw do
  
  resources :rooms do
    resources :reservations
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions
  get "/current_user_registered_show" => "rooms#current_user_registered_show"
  get "/reservations" => "reservations#index"
  get '/search' => 'searches#search'
  get '/search_place' => 'searches#search_place'
  get '/reservation_page' => 'rooms#reservation_page'
  get '/current_user_reservation' => "reservations#current_user_reservations"
end 
