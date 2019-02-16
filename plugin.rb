# name: dev-rel-automated-messages
# version: 1.1.0
# authors: boyned/Kampfkarren

enabled_site_setting :dev_rel_automated_messages

after_initialize do
	DiscourseEvent.on(:topic_created) do |topic|
		if topic.subtype == TopicSubtype.system_message
			if topic.title == I18n.t("system_messages.welcome_tl1_user.subject_template") ||
				topic.title == I18n.t("system_messages.welcome_tl2_user.subject_template")
			then
				dev_rel = Group.find_by(name: "DevRelationsTeam").users.sample
				topic.posts.first.set_owner(dev_rel, dev_rel, true)
				topic.save
				topic.reload
			end
		end
	end
end
