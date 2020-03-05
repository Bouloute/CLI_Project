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
end