
require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../model'

describe Event do
  before do
    @parameters = {
      :name => 'event',
      :member_info => 'name phonenumber'
    }
  end

  after do
    Event.destroy
    Member.destroy
  end

  it 'has uuid as primay key' do
    class DummyEvent < Event; end
    DummyEvent.class_eval  do
      def before_save
        super
        self.id = 'uuid'
      end
    end

    event = DummyEvent.create(@parameters)
    event.id.should == 'uuid'
  end

  it 'has member info' do
    event = Event.create(
      :name => 'event',
      :member_info => 'name | phonenumber')
    event.member_info.should == ['name', 'phonenumber']
  end

  it 'can set member info in Japanese' do
    event = Event.create(
      :name => 'event',
      :member_info => '名前 | 電話番号 | 住所')
    event.member_info.should == ['名前', '電話番号', '住所']
  end

  it 'can set more example of member info' do
    result = [
      %w[hoge piyo fuga],
      %w[ほげ ぴよ ふが],
      ['hoge piyo', 'fuga']
    ]
    [
      'hoge |    piyo | fuga',
      'hoge|piyo | fuga',
      'hoge|piyo | fuga',
      'hoge| piyo |fuga',
      'hoge |piyo | fuga',
      'hoge|piyo|fuga',
      'hoge || piyo | fuga',
      'hoge piyo | fuga',
      'ほげ |    ぴよ | ふが',
      'ほげ|ぴよ | ふが',
      'ほげ|ぴよ | ふが',
      'ほげ| ぴよ |ふが',
      'ほげ |ぴよ | ふが',
      'ほげ|ぴよ|ふが',
      'ほげ　|　ぴよ　|　ふが',
      'ほげ　|　ぴよ　|　ふが',
    ].each do |info|
      event = Event.create(
        :name => 'event',
        :member_info => info)
      result.should be_include(event.member_info)
    end
  end

  it 'must set updated_at automaticaly' do
    event = Event.create(@parameters)
    event.updated_at.should be_close(Time.now, 1)
  end

  it 'has many members' do
    event = Event.create(@parameters)
    10.times do |i|
      Member.create(:serialized_data => i, :event => event)
    end
    event.members.count.should == 10
  end
end

describe Member do
  before do
    @event = Event.create(
      :name => 'testevent',
      :member_info => 'name phonenumber')
  end

  after do
    Event.destroy
    Member.destroy
  end

  it 'belongs to event' do
    member = Member.create do |m|
      m.data = 'data'
      m.event = @event
    end
    member.event.should == @event
    @event.members.first.should == member
  end

  it 'has data which is serialized by Marshal' do
    data = ['name', 'phonenumber']
    member = Member.create do |m|
      m.data = data
      m.event = @event
    end
    member.data.should == data
    member.data[0].should == 'name'
    member.data[1].should == 'phonenumber'
  end
end

