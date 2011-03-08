require 'bundler'
Bundler.require
require 'sinatra'
require './what_week_is_it.rb'
run what_week_is_it.new
