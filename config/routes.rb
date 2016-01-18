Rails.application.routes.draw do
  root to: redirect('http://intro.parti.xyz/')
  sso_devise

  resources :positions do
    shallow do
      resources :opinions
      resources :votes
    end
  end

  resources :supports do
    collection do
      delete :cancel
    end
  end
end
