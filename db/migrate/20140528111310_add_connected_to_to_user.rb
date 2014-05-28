class AddConnectedToToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :connected_to
    end
  end
end
