Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
 root to: "welcome#index"


 namespace :api do
    namespace :v1 do
      devise_for :users , controllers: { sessions: 'api/v1/users/sessions',
                                         passwords: 'api/v1/users/passwords',
                                         registrations: 'api/v1/users/registrations'
                                        }
      resources :locations do
        collection do
          post "create_route"
        end
      end
    end
  end


  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
      }

    resources :locations
end
