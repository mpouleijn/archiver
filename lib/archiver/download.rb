module S3

	class Download

		PARENT_DIR = "/tmp"

		def initialize(options={})
			@directory = options[:dir]
			@link = options[:link]
			@limit_rate = options[:rate]
			@name = options[:name]
		end

		def start
			$logger.debug "Starting download -> wget"
			$logger.debug "[@directory] = #{@directory}"
			$logger.debug "[@link] = #{@link}"
			$logger.debug "[@limit_rate] = #{@limit_rate}"
			$logger.debug "[@name] = #{@name}"

			command = "wget #{@link} -O #{@name} --limit-rate=#{@limit_rate}"
			system command

			$logger.debug "Starting download -> wget"
		end

	end


end