class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :openstax_uid

      t.timestamps
    end
  end
end
