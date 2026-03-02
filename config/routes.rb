Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               registrations: 'users/registrations'
             }

  namespace :api do
    resources :expenses
    resource :profile, only: [:show, :update]
    resources :suppliers, only: [:index, :show]
  end
end