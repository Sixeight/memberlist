#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'

require 'model'

get '/' do
  haml :index
end

get '/event/init' do
  haml :init, :locals => { :event_name => params[:event_name] }
end

put '/event/create' do
  event = Event.create(
    :name => params[:event_name],
    :member_info => params[:infos])
  redirect '/' unless event
  redirect '/event/' + event.id
end

get '/event/:id' do
  @event = Event[:id => params[:id]]
  haml :event
end

put '/add/member/to/:id' do
  return unless request.xhr?
  return if params[:data].all? {|e| e == '-' }
  if event = Event[:id => params[:id]]
    Member.create do |m|
      m.data = params[:data]
      m.event = event
    end
  end
end

delete '/delete/member/:id' do
  return unless request.xhr?
  if member = Member[:id => params[:id]]
    member.destroy
  end
end

get '/css/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end

