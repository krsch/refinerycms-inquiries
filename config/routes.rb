Refinery::Application.routes.draw do
  get '/contact', :to => 'inquiries#new', :as => 'new_inquiry'
  get '/questions', :to => 'inquiries#index', :as => 'list_inquiries'
  resources :contact,
            :only => [:create, :show],
            :as => :inquiries,
            :controller => 'inquiries' do
    collection do
      get :thank_you
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :inquiries, :only => [:index, :show, :destroy, :edit, :update] do
      collection do
        get :spam
      end
      member do
        get :toggle_spam
      end
    end
    resources :inquiry_settings, :only => [:edit, :update]
    resources :inquiry_categories, :only => [:index, :create]
  end
end
