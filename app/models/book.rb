class Book < ActiveRecord::Base
    def self.all_genre ; ['Science fiction','Drama','Action and Adventure','Romance','Mystery','Horror'] ; end #  shortcut: array of strings
    validates :title, :presence => true
    #validates :publish_date, :presence => true
    validates :genre, :inclusion => {:in => Book.all_genre}
    #validate :all_number_isbn
    
    #def all_number_isbn
        #errors.add(:isbn_number, 'must be all numbers') if
          #isbn && !is_number?(isbn_number)
    #end
    
    #def is_number? string
        #true if Float(string) rescue false
    #end

    def self.similar_books(book)
        Book.where(author: book.author)
    end
end