FactoryBot.define do
  factory :game do
    mode { [:pvp, :pve, :pvp_pve].sample }
    release_date { Faker::Date.between(from: '1980-01-01', to: Date.today) }
    developer { Faker::Company.name }
    system_requirement
  end
end
