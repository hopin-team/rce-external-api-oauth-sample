require 'rubygems'
require "bundler/setup"

Bundler.require

require './hopin_auth_sample'
run Sinatra::Application
