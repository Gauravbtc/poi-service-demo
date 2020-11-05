FactoryBot.define do
  factory :location do
    address {"Doho Park"}
    # get user from user factory
    user
  end
end