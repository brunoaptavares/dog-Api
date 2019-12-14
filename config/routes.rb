Rails.application.routes.draw do
  resources :dog_walkings, except: %i[new edit update destroy] do
    collection do
      post ':id/start_walk', to: 'dog_walkings#start_walk'
      post ':id/finish_walk', to: 'dog_walkings#finish_walk'
      post ':id/cancel_walk', to: 'dog_walkings#cancel_walk'
    end
  end

  resources :clients, except: %i[destroy]
  resources :providers, except: %i[destroy]
end
