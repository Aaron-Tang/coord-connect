Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	resources :course
  	resources :applied_applicants
	get '/courses', to: 'course#index'
	get '/courses/:id', to: 'course#show'
	post '/courses', to: 'course#create'
	put '/courses/:id', to: 'course#update'
	get '/courses/:id/applicants', to: 'course#all_applicants'
  get '/assignments/for_course/:course_code', to: 'applied_applicants#for_course'
end
