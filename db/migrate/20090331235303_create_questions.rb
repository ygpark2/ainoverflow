class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.text :parsed_body
      t.integer :total_views, :default => 0
      t.integer :answers_count, :default => 0
      t.references :user
      t.boolean :flag, :default => false
      t.boolean :answered, :default => false
      t.boolean :banned, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
