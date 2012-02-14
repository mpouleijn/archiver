require "mongoid"
require "mongoid_slug"
require "mongoid_acts_as_tree"

Mongoid.skip_version_check = true
File.open(File.join(File.dirname(__FILE__), '/mongoid.yml'), 'r') do |f|
  @settings = YAML.load(f)['production']
end

port = @settings["port"].nil? ? Mongo::Connection::DEFAULT_PORT : @settings["port"]
connection = Mongo::Connection.new(@settings["host"], port )
Mongoid.database = connection.db(@settings["database"])
if @settings["username"]
  Mongoid.database.authenticate(@settings["username"], @settings["password"])
end



# Serialize Mongo object IDs as a string
# (default uses a YAML representation)
class BSON::ObjectId

  def to_xml(options)
    key = ActiveSupport::XmlMini::rename_key(options[:root], options)
    options[:builder].tag!(key, to_s)
  end
end
