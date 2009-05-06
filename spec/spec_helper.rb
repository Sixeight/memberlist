
require 'rubygems'
require 'spec'
require 'spec/interop/test'
require 'sinatra'
require 'sinatra/test'

Test::Unit::TestCase.__send__ :include, Sinatra::Test

set :environment, :test

