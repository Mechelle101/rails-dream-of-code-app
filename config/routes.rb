Rails.application.routes.draw do
  # core resources used in the app
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :coding_classes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  # when GET hits /trimesters run TrimesterController#index
  resources :trimesters, only: [:index, :show, :edit, :update]
  put "/trimester/:id", to: "trimesters#update", as: :update_trimester
  
  # when GET hits /mentors run MentorController#index
  resources :mentors, only: [:index, :show]

  # when visiting /dashboard call the AdminDashboardController
  get "/dashboard", to: "admin_dashboard#index"

  resources :courses do 
    # nested submissions
    resources :submissions, only: [:new, :create]
  end
end
