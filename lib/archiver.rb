require "archiver/version"

Dir[ File.dirname(__FILE__) + "/archiver/*.rb" ].each { |file| require(file) }


module Archiver
  autoload :CustomLogger, File.expand_path("../archiver/custom_logger.rb", __FILE__)
end
