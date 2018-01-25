class Book < ActiveRecord::Base
    def self.all_genre ; ['Science fiction','Drama','Action and Adventure','Romance','Mystery','Horror'] ; end
end