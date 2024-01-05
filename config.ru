require 'rubygems'
require "bundler/setup"

Bundler.require

require './oauth_sample'
run Sinatra::Application
