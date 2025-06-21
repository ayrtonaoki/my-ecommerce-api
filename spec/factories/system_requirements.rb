FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { "500 GB" }
    processor { "Intel Core i3" }
    memory { "4 GB" }
    video_board { "NVIDIA GeForce 1050" }
  end
end
