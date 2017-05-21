Rails.application.routes.draw do
root 'users#new'
get 'users/new'
post 'users/assign' => 'users#assign'

get 'users/workout'               =>          'users#workout'
get 'facebook/token'
get 'users/edit'                          =>        'users#edit'
get 'users/events'                      =>        'users#events'
get 'users/match'                      =>          'users#match'
get 'users/show'                        =>         'users#show'
get 'users/exercises'                  =>         'users#exercises'
get 'user_profile'                       =>         'users#info'
get 'auth/:provider/callback'     =>         'sessions#create'
get 'auth/facebook',                  as:          'facebook_login'
get 'logout'                                =>         'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
