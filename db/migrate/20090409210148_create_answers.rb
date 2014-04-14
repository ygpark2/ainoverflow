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

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
