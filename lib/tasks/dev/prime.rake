if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'Sample data for local development environment'
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      15.times do
        profile = [:admin, :client].sample
        create(:user, profile: profile)
      end

      system_requirements = []
      ['Basic', 'Intermediate', 'Advanced'].each do |sr_name|
        system_requirements << create(:system_requirement, name: sr_name)
      end

      15.times do
        coupon_status = [:active, :inactive].sample
        create(:coupon, status: coupon_status)
      end

      categories = []
      25.times do
        categories << create(:category, name: Faker::Game.unique.genre)
      end

      30.times do
        game_name = Faker::Game.unique.title
        availability = [:available, :unavailable].sample
        categories_pos = rand(3..25)
        categories_count = rand(0..3)
        game_categories_ids = Category.all[categories_pos - categories_count..categories_pos].map(&:id)
        game = create(:game, system_requirement: system_requirements.sample)
        create(:product, name: game_name, status: availability,
                         category_ids: game_categories_ids, productable: game)
      end

      50.times do
        game = Game.all[0...5].sample
        status = [:available, :in_use, :inactive].sample
        platform = [:steam, :battle_net, :origin].sample
        create(:license, status: status, platform: platform, game: game)
      end

      10.times do
        product = Product.all.sample
        (1..10).to_a.sample.times do
          product.wish_items.create(user: User.all.sample)
        end
      end
    end
  end
end
