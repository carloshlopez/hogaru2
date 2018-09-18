Rails.application.routes.draw do
  
  
  resources :announcements do 
    get 'mark_as_seen'
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }, 
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }


  resources :users
  root 'home#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
