Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
      namespace :v1 do
        resources :schedule, only: [:show, :create, :destroy] do 
        end
      end
    end
end
