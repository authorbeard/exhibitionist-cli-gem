module Exhibitionist

  require 'nokogiri'
  require 'open-uri'
  require 'pry'

  require_relative './exhibitionist/version.rb'
  require_relative "./exhibitionist/scraper"
  require_relative "./exhibitionist/museum"
  require_relative "./exhibitionist/exhibit"
  require_relative "./exhibitionist/cli.rb"
  
  
end
