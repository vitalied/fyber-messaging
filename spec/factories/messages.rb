FactoryBot.define do
  factory :message do
    sender { create :user }
    content { Faker::Lorem.paragraph }
  end
end
