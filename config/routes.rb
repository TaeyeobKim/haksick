Rails.application.routes.draw do
  root 'home#index'
  get '/get_bob' => 'home#get_bob'
end
