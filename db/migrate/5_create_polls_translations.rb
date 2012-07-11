class CreatePollsTranslations < ActiveRecord::Migration
  def up
    Refinery::Polls::Question.create_translation_table!({
      :title => :string,
      :slug => :string
    }, {
      :migrate_data => true
    })
    Refinery::Polls::Answer.create_translation_table!({
      :title => :string,
      :slug => :string
    }, {
      :migrate_data => true
    })

  end

  def down
    Refinery::Polls::Question.drop_translation_table! :migrate_data => true
    Refinery::Polls::Answer.drop_translation_table! :migrate_data => true
  end
end