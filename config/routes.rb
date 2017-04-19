Rails.application.routes.draw do
    root 'users#index'

    get '/events' => 'users#events_dashboard'
    get 'events/:id' => 'users#event_detail'
    get '/user/:id' => 'users#edit'
    get '/logout' => 'users#logout'
    get '/join_event/:event_id' => 'users#join_event'
    get '/cancel/:event_id' => 'users#cancel'
    get '/edit/:event_id' => 'users#edit_event'
    get '/destroy_event/:event_id' => 'users#destroy_event'

    post '/update_event/:event_id' => 'users#update_event'
    post '/register' => 'users#register'
    post '/add_event' => 'users#add_event'
    post '/login' => 'users#login'
    post '/profile_edit' => 'users#profile_edit'
    post '/add_comment/:event_id' => 'users#add_comment'


end
