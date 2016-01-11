Rails.application.routes.draw do
  root to: redirect('http://intro.parti.xyz/')

  get 'home', to: 'pages#home'
end
