require "mongoid"

class Video
  include Mongoid::Document
  include Mongoid::Timestamps
 
  
  # Used by Content Manager.
  field :cidentifier,							  	:type => Integer 
  
  # Used by Streaming Server.
  field :video_id,									  :type => String
  field :video_id_656x416,					  :type => String
  field :audio_id,                    :type => String
  
  # Oembed Fields.
  field :provider_url,							  :type => String
  field :provider_name,							  :type => String
  field :type,						  					:type => String
  field :title,					 	 					  :type => String
  field :description,								  :type => String
  field :url,												  :type => String
  field :height,										  :type => Integer
  field :width,											  :type => Integer
  field :html5,											  :type => String
  field :thumbnail_url,							  :type => String
  field :thumbnail_height,					  :type => Integer
  field :thumbnail_width,						  :type => Integer
  field :author,										  :type => String
  field :author_url,								  :type => String
  field :version,										  :type => String
  
  field :html,											  :type => String
  field :html_ipad, 								  :type => String
  
  # This is a mix of category, datasource and keywords.
  field :keywords,                    :type => String # space seperated.
  field :category_name,               :type => String # space seperated.
  field :path,                        :type => String
  field :source_url,                  :type => String
  
  # Added new fields 09/19/2011.
  field :original_date,               :type => Date
  field :date_in_words,               :type => String
  field :duration ,                   :type => Float
  field :output_duration,             :type => Float
  
  # Original file downloaded.
  field :download_url,							  :type => String
  field :s3_url,										  :type => String
  field :s3_file_size,				  			:type => Integer
  
  field :demux_audio_url,			  			:type => String
  field :demux_audio_size,			  		:type => Integer
    
  field :demux_video_url,   					:type => String
  field :demux_video_size,  					:type => Integer


  field :demux_audio_url_new,         :type => String
  field :demux_audio_size_new,        :type => Integer
    
  field :demux_video_url_new,         :type => String
  field :demux_video_size_new,        :type => Integer
  
  
  field :demux_video_656x416_url,     :type => String
  field :demux_video_656x416_size,  	:type => Integer

  # Timelines for audio and video.
  field :audio_timeline,              :type => String
  field :video_timeline,              :type => String

  field :original_archived,           :type => Boolean

  # Status fields.
  field :is_downloaded,   						:type => Boolean, :default => false
  field :is_demuxed,     						  :type => Boolean, :default => false
  
end

