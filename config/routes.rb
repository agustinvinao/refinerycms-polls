Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :polls do
    resources :questions, :path => '', :only => [:index, :show] do
      member do
        post 'submit'
        get 'widget'
      end
    end
  end
  # namespace :poll_answers do
  #   resources :polls, :path => '', :only => [:index, :show]
  # end

  # Admin routes
  namespace :polls, :path => '' do
    namespace :admin, :path => 'refinery' do
      match "/refinery/questions/:question_id/answers" => "refinery/polls/admin/answers#index", :as => :answer
      resources :questions, :except => :show do
        collection do
          post :update_positions
        end
        resources :answers, :except => :show do
          collection do
            post :update_positions
          end
        end
      end
    end
  end

end
