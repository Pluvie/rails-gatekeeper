FactoryBot.define do
  
  factory :model,     class: Gatekeeper::Model do
    string_field      { Faker::Movies::StarWars.vehicle }
    number_field      { rand 0..100 }
    date_field        { Time.at(rand * Time.now.to_i) }
  end

end
