Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "service/create_case"
  # get "service/create_case"
  
  post "service/create_problem"
  # get "service/create_problem"
end
