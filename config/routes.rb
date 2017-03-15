Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get '/courses', to: 'course#index'  
	get '/courses/id/applicants', to: 'course#all_applicants'
end
