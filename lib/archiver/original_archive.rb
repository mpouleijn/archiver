require 'aws/s3'
require "net/http"

module S3
	
	class Archiver
		
		def initialize(options ={})
			data = options[:data]
			
			if data == "original"
				@field = Constants::ORIGINAL.fetch(:field)
				@dir = Constants::ORIGINAL.fetch(:dir)
				@update = Constants::ORIGINAL.fetch(:update)
			end
			$logger.debug "[@field] = #{@field}"
			$logger.debug "[@dir] = #{@dir}"
			$logger.debug "[@update] = #{@update}"
			$logger.debug "-> Initialized fields and directory."
		end	



		def archive()
			begin
				$logger.debug "~> Retreving list of videos to be archived."
				videos = get_videos
				videos.each do |video|
					$logger.debug "----------------------------------------------"
					$logger.debug "-> Archiving video id : #{video._id.to_s}"


					link = video.s3_url

					unless link_exists(link, video)
						video.original_archived = true
						video.save
						next
					end

					extension = get_extension(link)
    				file_name = @dir + "/" + video._id.to_s + extension
					
					S3::Download.new(
						:dir => @dir,
						:link => link,
						:name => file_name,
						:rate => "5m"
					).start

					if File.exists?(file_name)

						size = File.size(file_name)
						if size == video.s3_file_size

							$logger.debug "xx Deleting from s3."
							flag = delete_from_s3(video.s3_url)
							delete_from_s3(video.download_url) if video.download_url.include?("feed-video-original/")
							$logger.debug "xx Deleted from s3."
							if flag
								video.original_archived = true
								video.save
							end
						end
					end

					$logger.debug "-> Done archiving video id : #{video._id.to_s}"
				end
			rescue Exception => e
				$logger.error e.message
				$logger.error e.backtrace
			end
		end

		def link_exists(link, video)
			url = URI.parse(link)
			req = Net::HTTP.new(url.host, url.port)
			res = req.request_head(url.path)
			if res.code == 200
				return true
			else
				return false
			end
		end

		def delete_from_s3(link)
			split_link = link.split("/")	
			object = split_link[-1]
			bucket = split_link[-2]
	    	@aws_s3 = Amazon::S3.new(bucket)
	    	@aws_s3.connect
	    	@aws_s3.delete_s3_url(object)
		end


		def get_videos
			videos = Video.where(@update => nil, :state => "active").only(:_id, @field, @update, :download_url, :s3_file_size).asc(:updated_at).limit(1000)
			videos
		end


		def get_extension(uri)
  			extension = File.extname uri.downcase
    		extension.nil? || extension.empty? || extension.length > 4 ? Constants::DEFAULT_EXT : extension
  		end
  
	end

end