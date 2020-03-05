class Game 
    attr_reader :game_data
    @@all = []

    def initialize(game_data)
        @game_data = game_data
        @@all.push(self)
    end


    def self.display_team_names_only
        @@all.each_with_index{|game, index| 
            if game.game_data[:team_two].size + game.game_data[:team_one].size >= 17
                puts "#{index + 1}. #{game.game_data[:team_one]} vs #{game.game_data[:team_two]}\t#{game.game_data[:time]}\t#{game.game_data[:place]}"
            else
                puts "#{index + 1}. #{game.game_data[:team_one]} vs #{game.game_data[:team_two]}\t\t#{game.game_data[:time]}\t#{game.game_data[:place]}"
            end
        }
    end

    def self.all 
        @@all
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