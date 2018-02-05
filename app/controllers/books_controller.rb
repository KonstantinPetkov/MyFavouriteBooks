class BooksController < ApplicationController
  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'publish_date'      
      ordering,@date_header = {:publish_date => :asc}, 'hilite'
    end
    
    @all_genre = Book.all_genre
    
    if params[:genres]
      @selected_genres = params[:genres].permit!
    elsif session[:genres]
      @selected_genres = session[:genres]
    else
      @selected_genres = {}  
    end
    
    if @selected_genres == {}
      @selected_genres = Hash[@all_genre.map {|genre| [genre, genre]}]
    end
    
    if params[:sort] != session[:sort] or params[:genres] != session[:genres]
      session[:sort] = sort
      session[:genres] = @selected_genres
      redirect_to :sort => sort, :genres => @selected_genres and return
    end
 
    @books = Book.where(genre: @selected_genres.keys).order(ordering)
    
  end
  
  def search_similar_books
    @book = Book.find(params[:id])
    if @book.author.to_s.empty?
      flash[:warning] = "'#{@book.title}' has no author info"
      redirect_to books_path
    else
      @books = Book.similar_books(@book)
    end
  end

  def show
    id = params[:id]
    @book = Book.find(id)
  end

  def new
    @book = Book.new
    # default: render 'new' template
  end
  
  def create
    params.require(:book)
    permitted = params[:book].permit(:title,:genre,:description,:isbn_number,:author,:publish_date)
    @book = Book.create!(permitted)
    if @book.save
      flash[:success] = "#{@book.title} was successfully created."
      redirect_to books_path
    else
      render 'new'
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find params[:id]
    params.require(:book)
    permitted = params[:book].permit(:title,:genre,:description, :isbn_number,:author,:publish_date)
    @book.update_attributes!(permitted)
    if @book.update_attributes(permitted)
      flash[:success] = "#{@book.title} was successfully updated."
      redirect_to books_path(@book)
    else
      render 'edit'
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:success] = "Book '#{@book.title}' deleted."
    redirect_to books_path
  end
end