class CreatePollsVotes < ActiveRecord::Migration
  def self.up
    create_table Refinery::Polls::Vote.table_name, :id => true do |t|
      t.integer :question_id
      t.integer :answer_id
      t.string  :ip
      t.timestamps
    end
  end

  def self.down
    drop_table Refinery::Polls::Vote.table_name
  end
end