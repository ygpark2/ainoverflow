class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.integer :flaggeagle_id
      t.string :flaggeable_type
      t.references :user
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :flags
  end
end
