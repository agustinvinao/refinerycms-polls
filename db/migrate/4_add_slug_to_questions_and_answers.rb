class AddSlugToQuestionsAndAnswers < ActiveRecord::Migration
  def change
    add_column Refinery::Polls::Question.table_name, :slug, :string
    add_index Refinery::Polls::Question.table_name, :slug

    add_column Refinery::Polls::Answer.table_name, :slug, :string
    add_index Refinery::Polls::Answer.table_name, :slug
  end
end