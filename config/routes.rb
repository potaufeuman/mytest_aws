Rails.application.routes.draw do
  root "sessions#new"
  get '/:locale' => 'sessions#new', as: "locale"
  get '/' => redirect("/ja")
  post '/', to: 'sessions#create'
  get 'password_resets/new'
  get 'password_resets/edit'
  scope ":/locale", locale: /en|ja/ do
    # scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    get  '/',        to: 'sessions#new'
    post '/',        to: 'sessions#create'
    get  '/help',    to: 'static_pages#help'
    get  '/about',   to: 'static_pages#about'
    get  '/privacy', to: 'static_pages#privacy'
    get  '/term',    to: 'static_pages#term'
    get  '/language', to: 'static_pages#language'
    get  '/search', to: 'static_pages#search'
    get  '/searchresult', to: 'static_pages#searchresult'
    get  '/signup',  to: 'users#new'
    post '/signup',  to: 'users#create'
    delete '/logout',    to: 'sessions#destroy'
    get  '/tester',      to: 'tests#new'
    post '/tester',      to: 'tests#create'
    get  '/mytests',     to: 'tests#my_index'
    get  '/mytests/:id', to: 'tests#my_show'
    resources :users
    resources :account_activations, only: [:edit]
    resources :password_resets,     only: [:new, :create, :edit, :update]
    resources :tests do
      resources :questions do
        member do
          get :answerring
          post :post_answerring
        end
        resources :selects, :answers, only: [:new, :create, :edit, :destroy]
      end
    end
    resources :testeds do
      resources :tests do
        resources :answers, only: [:index, :show, :destroy]
      end
    end
  end
end
