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
  match '/questions/:inquiry_category_id' => 'inquiries#index', :as => 'list_category'

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :inquiries, :only => [:index, :show, :destroy, :edit, :update, :new, :create] do
      collection do
	get 'export(/:status)', :action => 'new_export', :as => 'newexport'
	post :export
	get 'status/:status', :action => 'index', :as => 'status'
      end
    end
    resources :inquiry_settings, :only => [:edit, :update]
    resources :inquiry_categories, :only => [:index, :create]
  end
end
