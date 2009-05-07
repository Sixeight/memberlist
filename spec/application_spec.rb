
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../app'

describe 'application' do
  after do
    Event.destroy
    Member.destroy
  end

  it 'creates a new event' do
    put '/event/create',
      { :event_name => 'event',
        :infos      => 'name | phonenumber' }
    Event.count.should == 1
    event = Event.first
    event.name.should == 'event'
    event.member_info == %w[ name phonenumber ]
  end
end
