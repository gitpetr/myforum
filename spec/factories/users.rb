FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email
    password '111111'
    password_confirmation '111111'
  end
end
