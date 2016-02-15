Rails.application.routes.draw do
  root to: redirect('http://intro.parti.xyz/')
  sso_devise

  resources :issues do

  end

  resources :positions do
    shallow do
      resources :opinions do
        resources :likes, except: :destory do
          collection do
            delete :by_me, to: 'likes#destroy_by_me'
          end
        end
      end
      resources :votes
    end
  end

  resources :supports do
    collection do
      delete :cancel
    end
  end
end
