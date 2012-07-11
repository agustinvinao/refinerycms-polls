if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinerycms-polls').blank?
      user.plugins.create(:name => 'refinerycms-polls',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end


url = "/polls"
if defined?(::Refinery::Page) && ::Refinery::Page.where(:link_url => url).empty?
  page = ::Refinery::Page.create(
    :title => 'Polls',
    :link_url => url,
    :deletable => false,
    :show_in_menu => false,
    :menu_match => "^#{url}(\/|\/.+?|)$"
  )
  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

