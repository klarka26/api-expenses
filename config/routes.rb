Rails.application.routes.draw do
  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               registrations: "users/registrations"
             }

  namespace :api do
    get "/make_admin", to: "debug#make_admin"
    resources :expenses do
      collection do
        get "receipt/:uid", to: "expenses#receipt"
      end
    end

    post "/decode_bysquare", to: "expenses#decode_bysquare"
    resource :profile, only: [ :show, :update ]
    resources :suppliers, only: [ :index, :show ]
  end
end
