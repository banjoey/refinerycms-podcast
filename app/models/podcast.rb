class Podcast < ActiveRecord::Base
  require 'rubygems'
  require 'mp3info'

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
  
  # Sets up auto-field recognition from mp3 file
  before_validation :set_fields_from_file
  def set_fields_from_file
    # TODO: Get this working for production/development environments...
    production_working_dir = "/home/mikmattl/rails_apps/wcoc/public/system/resources/"
    working_dir = Dir.pwd
    file_path = working_dir + "/public/system/resources/" + file.file_uid
    # return unless file? 
    begin

      # same code as before, but use self.title = xxx if self.title.blank? 
      Mp3Info.open(file_path) do |audio_info|
        self.title =  audio_info.tag.title if self.title.blank?
        self.author = audio_info.tag.artist if self.author.blank?
        self.description = audio_info.tag.comments.gsub!("?","") if self.description.blank?
        self.duration = format_duration(audio_info.tag.length) if self.duration.blank?
      end
    rescue Exception => exc
      logger.error("Error in set_fields_from_audio in episode model #{exc.message}")
      #flash[:notice] = "Error reading MP3 Info"
    end
  end
  
  def format_duration(total_duration_in_seconds)
    # irb(main):016:0> Time.at(7683).gmtime.strftime('%R:%S')
    hours = total_duration_in_seconds/3600.to_i
    minutes = (total_duration_in_seconds/60 - hours * 60).to_i
    seconds = (total_duration_in_seconds - (minutes * 60 + hours * 3600))
    return sprintf("%02d:%02d:%02d", hours, minutes, seconds)
  end

end
