require "bundler/gem_tasks"
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'


require File.expand_path(File.dirname(__FILE__)) + '/lib/archiver.rb'
oarchive_log = File.dirname(__FILE__)  + "/logs/original-archive.log"

desc 'Archives originally downloaded video files from amazon s3.'
namespace :archive do
  task :original do

  	if File.new(File.dirname(__FILE__) + "/temp/orig.lock").flock(File::LOCK_EX | File::LOCK_NB)
    	$logger = CustomLogger.get_logger(oarchive_log)
  		$logger.debug "~> Initialized logging: start"
    	S3::Archiver.new({:data => "original"}).archive	
  	else
    	raise "Another instance of this program is running"
  	end

  end  
end
