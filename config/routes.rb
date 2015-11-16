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
  
  get    '/events/:id/add_admin', to: 'event_managements#new', as: 'new_admin'
  post   'event_managements' => 'event_managements#create'

  get    '/invites', to: 'event_invitations#index', as: 'invites'

  put    '/invites/:id/accept', to: 'event_invitations#accept', as: 'accept_invite'
  put    '/invites/:id/decline', to: 'event_invitations#decline', as: 'decline_invite'
  get    '/invites/:id',         to: 'event_invitations#show', as: 'event_invitation'
end
