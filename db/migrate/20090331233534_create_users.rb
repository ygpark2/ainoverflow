class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.boolean :admin, :default => true
      t.integer :total_votes, :default => 0
      t.integer :total_answers, :default => 0
      t.integer :total_questions, :default => 0
      t.integer :total_tags, :default => 0
      t.integer :total_points, :default => 1
      t.boolean :banned, :default => false
      t.datetime :last_request_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end

end
