class CreateUserInterestJoinTable < ActiveRecord::Migration
  def up
    create_table :users_interests do |t|
      t.integer :user_id
      t.integer :interest_id
    end
  end

  def down
    drop_table :users_interests
  end
end
