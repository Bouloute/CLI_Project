require 'nokogiri'
class Scraper
    attr_reader :scrapped 

    def initialize(path)
        @scrapped = scraper(path)

    end

    def scraper(index_url)
        students = []
        Nokogiri::HTML(open(index_url))
    end 
end