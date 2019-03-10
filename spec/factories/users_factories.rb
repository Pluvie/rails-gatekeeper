FactoryBot.define do

  factory :user,        class: Gatekeeper::User do
    name                { Faker::Movies::StarWars.character }
    role                { [ :admin, :editor, :viewer ].sample }
  end

end
