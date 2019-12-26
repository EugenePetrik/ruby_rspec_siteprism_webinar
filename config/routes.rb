# frozen_string_literal: true

Rails.application.routes.draw do
  root 'courses#index'
  resources :courses, except: %i[update edit destroy]
  get 'about', to: 'pages#about'
  get 'help', to: 'pages#help'
  get 'contact_us', to: 'pages#contact_us'
  resources :students, except: [:destroy]
  get 'login', to: 'logins#new'
  post 'login', to: 'logins#create'
  delete 'logout', to: 'logins#destroy'
  post 'course_enroll', to: 'student_courses#create'
end
