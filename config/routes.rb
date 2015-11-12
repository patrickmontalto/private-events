Rails.application.routes.draw do
  root                'static_pages#index'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :events
  get    '/events/:id/invitation', to: 'event_invitations#new', as: 'new_invitation'
  post   'event_invitations' => 'event_invitations#create'
end
