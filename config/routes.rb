Rails.application.routes.draw do
	root 'stocks#index'

	devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'sign_up' }
	resources :users, :only => [:show]
	resources :stocks, :only => [:index]
	resources :stock_histories

	get 'stocks/quote_search' => 'stocks#quote_search', :as => 'quote_search'
	get 'stocks/:symbol' => 'stocks#show', :as => 'stock'
	get 'stocks/:symbol/generate_history' => 'stock_histories#generate_history', :as => 'generate_history'

end
