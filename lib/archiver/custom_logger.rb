# Custom logging into log files.
# Required by resque to log STDOUTs.
require 'rubygems'
require 'lumberjack'


module CustomLogger
  
  class << self
  
    # Returns a custom logger for each feed.
    def get_logger(filename, options={})
      logger =  Lumberjack::Logger.new(filename, 
        :buffer_size => 0, 
        :level => Lumberjack::Severity::DEBUG)
      return logger
    end
  
  end
  
end
