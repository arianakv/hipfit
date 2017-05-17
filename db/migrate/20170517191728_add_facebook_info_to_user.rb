class AddFacebookInfoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :picture, :string
    add_column :users, :age_range, :string
    add_column :users, :user_location, :string
    add_column :users, :gender, :string
    add_column :users, :link, :string
  end
end
