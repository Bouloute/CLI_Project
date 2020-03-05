class Scraper
    def self.scraper(index_url)
        Nokogiri::HTML(open(index_url))
    end 

    def self.creator_from_data(scraped_data, row_index, number)
        data = {}
        collum_index = 0
        data_index = (number * (row_index - 1)) + 1
        number.times{
            data[scraped_data.css("th")[collum_index].text] = scraped_data.css("td")[data_index].text
            collum_index += 1
            data_index += 1
        }
        if number == 11 
            Team.new(data)
        else 
            Player.new(data)
        end
    end

    def self.set_from_scraped_data(index_url, class_name)
        scraped_data = Scraper.scraper(index_url)

        row_index = 1
        scraped_data.css("td").each_with_index{|row_info, element_index| 
            # 11 because there is 11 collums of information given one team
            if class_name.downcase == "team"
                if (11 * row_index + 1) == element_index 
                    creator_from_data(scraped_data, row_index, 11)
                    row_index += 1
                end
            # 19 because there is 19 collums of information given one player
            elsif class_name.downcase == "player"
                if (19 * row_index + 1) == element_index 
                    creator_from_data(scraped_data, row_index, 19)
                    row_index += 1
                end
            
            end
                
        }

    end

    def self.set_games_from_scraped_data(index_url)
        scraped_games = Scraper.scraper(index_url)
        
        game_data = {}
        scraped_games.css("td.TableBase-bodyTd").each_with_index{|game_info, index| 
            
            case index % 5
            
            when 0
                game_data[:team_one] = game_info.text.gsub(/\s+/, '')
            when 1
                game_data[:team_two] = game_info.text.gsub(/\s+/, '')
            when 2
                game_data[:time] = game_info.text.gsub(/\s+/, '')
                if game_data[:time].include?("NBCS")
                    game_data[:time] = game_data[:time].gsub("NBCS", "")
                end
            when 3
                game_data[:place] = game_info.text.gsub(/\s+/, '')
                Game.new(game_data)
                game_data = {}
            end
            
        }
    end
end