class Scraper
    def self.scraper(index_url)
        Nokogiri::HTML(open(index_url))
    end 
end