class CreateUserInterestJoinTable < ActiveRecord::Migration
  def up
    create_table :interests_users do |t|
      t.integer :user_id
      t.integer :interest_id
    end
  end

  def down
    drop_table :interests_users
  end
end
