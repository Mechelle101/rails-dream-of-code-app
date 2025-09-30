Rails.application.routes.draw do
  # core resources used in the app
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :coding_classes

  get 'login', to: 'sessions#new'
  get 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post 'login', to: 'sessions#create'

  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  # when visiting /dashboard call the AdminDashboardController
  get "/dashboard", to: "admin_dashboard#index"

  resources :trimesters, only: [:index, :show, :edit, :update]

  # adding redirect before courses resources eliminates the RecordNotFound error
  get "/courses/submissions", to: redirect("/courses")

  resources :courses do 
    resources :submissions, only: [:new, :create]
  end
end
