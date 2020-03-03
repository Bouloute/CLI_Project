module Scraper
   # attr_reader :scrapped 

    def initialize()#path)
        #@scrapped = scraper(path)

    end

    def scraper(index_url)
        Nokogiri::HTML(open(index_url))
    end 
end