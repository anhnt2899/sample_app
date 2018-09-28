Rails.application.routes.draw do
  root 'static_page#home'
  get 'static_page#home', to: "static_page#home"
  get '/help', to: "static_page#help"
  get '/about', to: "static_page#about"
  get '/contact', to: "static_page#contact"
  get '/new', to: 'user#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
