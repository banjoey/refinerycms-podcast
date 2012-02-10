class Podcast < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :author, :subtitle, :duration, :keywords, :summary, :content_types, :genres, :topics]
  
  validates :title, :presence => true, :uniqueness => true
  
  belongs_to :file, :class_name => 'Resource'
  #TODO: setup some js to take care of the tags
  acts_as_taggable_on :genres, :content_types, :topics

  belongs_to :photo, :class_name => 'Image'
  #not sure what these are
  has_many :author_resources, :as => :favoriteable, :dependent => :destroy
  default_scope :order => "published DESC"

  FEED_FIELDS = %w(podcast_title podcast_author podcast_explicit_flag podcast_description podcast_owner_name podcast_owner_email podcast_category podcast_subcategory)

  def episode_number
    #TODO: make the starting episode configurable
    episode = 0
    
    Podcast.find(:all, :order => "published ASC").each do |p|
      episode += 1
      break if p === self
    end
    
    episode
  end

end
