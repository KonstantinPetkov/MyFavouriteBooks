Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do resources :books
    get '/books/search_similar_books/:id', to: 'books#search_similar_books', as: 'search_similar_books'
    root :to => redirect('/books')
  end
end
