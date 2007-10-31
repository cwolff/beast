class Forum < ActiveRecord::Base
  acts_as_list

  validates_presence_of :name

  has_many :moderatorships, :dependent => :destroy
  has_many :moderators, :through => :moderatorships, :source => :user, :order => "#{User.table_name}.login"

  has_many :topics, :order => 'sticky desc, replied_at desc', :dependent => :destroy
  has_one  :first_topic, :class_name => 'Topic', :order => 'sticky desc, replied_at'

  # this is used to see if a forum is "fresh"... we can't use topics because it puts
  # stickies first even if they are not the most recently modified
  has_many :recent_topics, :class_name => 'Topic', :order => 'replied_at DESC'
  has_one  :recent_topic,  :class_name => 'Topic', :order => 'replied_at DESC'

  has_many :posts,     :order => "#{Post.table_name}.created_at DESC"
  has_one  :last_post, :order => "#{Post.table_name}.created_at DESC", :class_name => 'Post'

  format_attribute :description
end
