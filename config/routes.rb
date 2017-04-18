Rails.application.routes.draw do 
 devise_for :users

  namespace "api" do
  	post "login" => "sessions#create"
  	
  	resources :users
  end 

  scope "cms" do
    resources :users
    resources :gyms do 
      resources :events
    end
  end



  root "users#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
