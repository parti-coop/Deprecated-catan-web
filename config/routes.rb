Rails.application.routes.draw do
  root to: redirect('http://intro.parti.xyz/')
  sso_devise

  get 'home', to: 'pages#home'
end
