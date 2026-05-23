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
    resources :expenses do
      collection do
        get "receipt/:uid", to: "expenses#receipt"
        post "/decode_bysquare", to: "expenses#decode_bysquare"
      end
    end

    resource :profile, only: [:show, :update]
    resources :suppliers, only: [:index, :show]

  end
end