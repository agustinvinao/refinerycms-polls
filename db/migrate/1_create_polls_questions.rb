class CreatePollsQuestions < ActiveRecord::Migration

  def up

    create_table Refinery::Polls::Question.table_name, :id => true do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :position
      t.timestamps
    end
    # User.find(:all).each do |user|
    #   user.plugins.create(:title => "Polls", :position => (user.plugins.maximum(:position) || -1) +1)
    # end
    # page = Page.create(
    #   :title => "Polls",
    #   :link_url => "/polls",
    #   :deletable => false,
    #   :position => ((Page.maximum(:position, :conditions => "parent_id IS NULL") || -1)+1),
    #   :menu_match => "^/polls(\/|\/.+?|)$"
    # )
    # RefinerySetting.find_or_set(:default_page_parts, ["Body", "Side Body"]).each do |default_page_part|
    #   page.parts.create(:title => default_page_part, :body => nil)
    # end
    
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-polls"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/polls/polls"})
    end

    drop_table Refinery::Polls::Question.table_name

  end

end
