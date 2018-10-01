Rails.application.routes.draw do
  
  
  resources :announcements do 
    get 'mark_as_seen'
  end
  
  devise_for :users, controllers: { sessions: 'users/sessions' }, 
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }


  resources :users
  root 'home#home'
  
  namespace :api, defaults: {format: 'json'} do
    
    
    namespace :v1 do
      resources :announcements do 
        get 'mark_as_seen'
      end

      devise_for :users, :controllers => { :registrations => 'api/v1/users/registrations', :sessions => 'api/v1/users/sessions' }, 
                         only: [:sessions, :registrations]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
