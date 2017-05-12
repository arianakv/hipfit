class User < ApplicationRecord
  validates :name, :email, presence: true

  def self.create_from_facebook(auth)
    User.create!(
      facebook_id: auth['uid'],
      name: auth['info']['name'],
      email: auth['info']['email']
    )
  end
end
