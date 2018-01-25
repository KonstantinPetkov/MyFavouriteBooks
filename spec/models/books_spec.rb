require "rails_helper"
 
describe Book do
  describe "search for similar books" do
    before :each do
      @book1 = FactoryBot.create(:book, title: 'The Godfather 1', author: 'Mario Puzo', isbn_number: 000123)
      @book2 = FactoryBot.create(:book, title: "The Sicilian", author: 'Mario Puzo', isbn_number: 000124)
      @book3 = FactoryBot.create(:book, title: 'Mark Twain', author: 'Tom Sawyer', isbn_number: 000125)
    end
    it 'it should find books with the same author' do
        expect(Book.similar_books(@book1)).to eq([@book1, @book2])
        expect(Book.similar_books(@book3)).to eq([@book3])
    end
    it 'it should not find books with different author' do
        expect(Book.similar_books(@book1)).to_not include([@book3])
        expect(Book.similar_books(@book3)).to_not include([@book1, @book2])
    end
  end
end