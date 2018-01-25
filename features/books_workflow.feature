Feature: search for books by author
 
  As a book lover
  So that I can find books with my favorite author
  I want to include and search on author information in books I enter
 
Background: books in database
 
  Given the following books exist:
  | title                       | genre           | isbn_number | author       | publish_date |
  | Nineteen Eighty-Four        | Science fiction | 000001      | Stephen King |   8-Jun-1949 |
  | Much Ado About Nothing      | Drama           | 000002      |              |   20-Jun-1598|
  | Dracula                     | Horror          | 000003      | Stephen King |   2-Jun-1897 |
  | Murder on the Orient Express| Mystery         | 000004      | Andy Weir    |   1-Jan-1934 |
  | Pride and Prejudice         | Romance         | 000005      | Harper Seng  |   1-Fev-1813 |

Scenario: add author to existing book
  When I go to the edit page for "Much Ado About Nothing"
  And  I fill in "Author" with "Harper Lee"
  And  I press "Update Book Info"
  Then I should be on the details page for "Much Ado About Nothing"
  And the author of "Much Ado About Nothing" should be "Harper Lee"

Scenario: find book with same author
  Given I am on the details page for "Nineteen Eighty-Four"
  When  I follow "Find Books With Same Author"
  Then  I should be on the Similar Books page for "It"
  And   I should see "Dracula"
  But   I should not see "Pride and Prejudice"
 
Scenario: can't find similar books if we don't know author (sad path)
  Given I am on the details page for "Much Ado About Nothing"
  Then  I should not see "Harper Lee"
  When  I follow "Find Books With Same Author"
  Then  I should be on the home page
  And   I should see "'Much Ado About Nothing' has no author info"