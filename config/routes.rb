Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	resources :course
  	resources :offer
  	resources :user
  	get '/users', to: 'user#index'
	get '/courses', to: 'course#index'
	get '/courses/:id', to: 'course#show'
	post '/courses', to: 'course#create'
	put '/courses/:id', to: 'course#update'
	get '/courses/:id/applicants', to: 'course#all_applicants'
  get '/assignments/for_course/:course_id', to: 'offer#for_course'
  post '/assignments/bulk_create', to: 'offer#bulk_create'
  put '/assignments/update_assignment', to: 'offer#update_assignment'
  put '/assignments/bulk_update_assignment', to: 'offer#bulk_update_assignment'
  put '/assignments/bulk_update_applicant_assignments', to: 'offer#bulk_update_applicant_assignments'
  get '/courses/:id/on_time', to: 'course#on_time'
  get '/courses/openings', to: 'course#openings'
  get '/assignments/:utorid', to: 'offer#get_all_offers_for_applicant'
  get '/assignments/:utorid/:course_id', to: 'offer#get_offer_for_application'
  get '/applicants', to: 'applicant#index'
end
