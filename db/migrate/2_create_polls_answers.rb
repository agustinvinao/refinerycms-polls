class CreatePollsAnswers < ActiveRecord::Migration
  def self.up
    create_table Refinery::Polls::Answer.table_name, :id => true do |t|
      t.string :title
      t.integer :votes_count, :default => 0
      t.integer :position
      t.integer :question_id
      t.timestamps
    end

  end

  def self.down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-polls"})
    end

    # no necesitamos una vista de las respuestas solas por ahora.
    # if defined?(::Refinery::Page)
    #   ::Refinery::Page.delete_all({:link_url => "/polls/polls_answers"})
    # end

    drop_table Refinery::Polls::Answer.table_name
  end
end