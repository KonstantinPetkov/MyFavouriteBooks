FactoryBot.define do
  factory :book do
    title 'Fake title' # default values
    genre 'Romance'
    publish_date { 10.years.ago }
  end
end