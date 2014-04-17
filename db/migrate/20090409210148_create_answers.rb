class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.text :body
      t.text :parsed_body
      t.references :user
      t.references :question
      t.boolean :flag, :default => false
      t.boolean :selected, :default => false
      t.boolean :banned, :default => false
      t.integer :cached_votes_total, :default => 0
      t.integer :cached_votes_score, :default => 0
      t.integer :cached_votes_up, :default => 0
      t.integer :cached_votes_down, :default => 0
      t.integer :cached_weighted_score, :default => 0
      t.index :cached_votes_total
      t.index :cached_votes_score
      t.index :cached_votes_up
      t.index :cached_votes_down
      t.index :cached_weighted_score

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
