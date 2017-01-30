# == Route Map
#
#                  Prefix Verb   URI Pattern                           Controller#Action
#        new_user_session GET    /api/auth/sign_in(.:format)           devise_token_auth/sessions#new {:format=>"json"}
#            user_session POST   /api/auth/sign_in(.:format)           devise_token_auth/sessions#create {:format=>"json"}
#    destroy_user_session DELETE /api/auth/sign_out(.:format)          devise_token_auth/sessions#destroy {:format=>"json"}
# api_auth_validate_token GET    /api/auth/validate_token(.:format)    devise_token_auth/token_validations#validate_token
#     batch_destroy_users DELETE /api/users/batch_destroy(.:format)    users#batch_destroy {:format=>"json"}
#                   users GET    /api/users(.:format)                  users#index {:format=>"json"}
#                         POST   /api/users(.:format)                  users#create {:format=>"json"}
#                    user GET    /api/users/:id(.:format)              users#show {:format=>"json"}
#                         PATCH  /api/users/:id(.:format)              users#update {:format=>"json"}
#                         PUT    /api/users/:id(.:format)              users#update {:format=>"json"}
#                         DELETE /api/users/:id(.:format)              users#destroy {:format=>"json"}
#  batch_destroy_partners DELETE /api/partners/batch_destroy(.:format) partners#batch_destroy {:format=>"json"}
#                partners GET    /api/partners(.:format)               partners#index {:format=>"json"}
#                         POST   /api/partners(.:format)               partners#create {:format=>"json"}
#                 partner GET    /api/partners/:id(.:format)           partners#show {:format=>"json"}
#                         PATCH  /api/partners/:id(.:format)           partners#update {:format=>"json"}
#                         PUT    /api/partners/:id(.:format)           partners#update {:format=>"json"}
#                         DELETE /api/partners/:id(.:format)           partners#destroy {:format=>"json"}
#

Rails.application.routes.draw do
  scope '/api', defaults: {format: 'json'} do
    mount_devise_token_auth_for 'User', at: 'auth', skip: [:registrations, :passwords]

    resources :users, :except => [:new, :edit] do
      collection do
        delete :batch_destroy
      end
    end

    resources :partners, :except => [:new, :edit] do
      collection do
        delete :batch_destroy
      end
    end
  end
end
