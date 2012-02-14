require 'aws/s3'

module Amazon
  # This is a module for uploading files to amazon S3.
  class S3
   
    CONFIG = "#{File.dirname(__FILE__)}/amazons3.yml"
    
    def initialize(bucket)
      $logger.debug "Initializing amazon s3 configuration."
      @config ||= YAML.load_file(CONFIG)
      @access_key_id     = @config['access_id']
      @secret_access_key = @config['secret_key']
      raise "Bucket Empty!" unless bucket
      @bucket = bucket
    end
    
    def connect
      AWS::S3::Base.establish_connection!(
        :access_key_id => @access_key_id, 
        :secret_access_key => @secret_access_key
      )
      @objectS3 = AWS::S3::S3Object
    rescue AWS::S3::S3Exception => e
      $logger.error "-> Error establishing s3 connection: #{e.message}"
    end
    
    def buckets
      return AWS::S3::Service.buckets 
    end

    def delete_s3_url(name)
      object = @objectS3.delete name.to_s, @bucket.to_s
      return true
    rescue Exception => e
      $logger.error "-> Error retrieving s3 url. #{e.message}"
      return nil
    end
    
  end
end