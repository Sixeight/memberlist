
require 'rubygems'
require 'sequel'
require 'uuid'

Sequel::Model.plugin :schema

configure :development do
  Sequel.sqlite('development.db')
end

configure :production do
  Sequel.sqlite('production.db')
end

configure :test do
  Sequel.sqlite('test.db')
end

class Event < Sequel::Model
  one_to_many :members

  unless table_exists?
    set_schema do
      primary_key :id, :string, :auto_increment => false
      string      :name, :null => false
      string      :member_info, :null => false
      timestamp   :updated_at
    end
    create_table
  end

  @@uuid = UUID.new

  def before_save
    self.id = @@uuid.generate
    self.updated_at = Time.now
  end

  alias :orig_info :member_info
  def member_info
    self.orig_info.split(/\|/).
      map(&:strip).
      map {|i| (i =~ /\A　*([^　]*)　*\z/) ? $1 : i }.
      reject(&:empty?)
  end
end

class Member < Sequel::Model
  many_to_one :event

  unless table_exists?
    set_schema do
      primary_key :id
      string      :serialized_data, :null => false
      string      :event_id, :null => false
    end
    create_table
  end

  def data
    Marshal.load self.serialized_data
  end

  def data=(val)
    self.serialized_data = Marshal.dump(val)
  end

end

