# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :wish_items

  validates :name, presence: true
  validates :profile, presence: true

  enum profile: { admin: 0, client: 1 }

  include NameSearchable
  include Paginatable
end
