Cryptopus::Application.routes.draw do
  scope "(:locale)", locale: /en|de|fr/ do
    resources :recryptrequests
    resources :teams do
      resources :teammembers
      resources :groups do
        resources :accounts do
          resources :items
        end
      end
    end

    namespace :admin do
      resource :settings do
        post 'update_all'
        get 'index'
      end
      resources :users do
        member do
          get 'unlock'
        end
      end
      resources :recryptrequests do
        collection do
          post 'resetpassword'
        end
      end
    end

    resource :login do
      get 'login'
      get 'show_update_password'
      post 'update_password'
      get 'logout'
      get 'noaccess'
      post 'authenticate'
      post 'changelocale'
    end

    get 'wizard', to: 'wizard#index'
    post 'wizard/apply'

    get 'search', to: 'search#index'
    get 'search/account', to: 'search#account'

    root to: 'search#index'
  end

  scope '/api', module: 'api' do
    resources :teams, except: [:new, :edit]  do
      member do
        get 'teammember_candidates'
      end
    end
  end
end
