require "./lib/CLI_Project/version"
require_relative "./CLI_Project/Cli"
require_relative "./CLI_Project/scraper"

require "pry"
require "nokogiri"
require "open-uri"

module CLI_Project
  class Error < StandardError; end
  # Your code goes here...
end