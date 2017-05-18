class User < ApplicationRecord
  has_many :user_exercises
  has_many :exercises, through: :user_exercises
  validates :name, :email, presence: true

  def self.create_from_facebook(auth)
    User.create!(
      facebook_id: auth['uid'],
      name: auth['info']['name'],
      email: auth['info']['email'],
    )
  end
end
