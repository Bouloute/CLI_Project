class Player
    attr_reader :player_data
    @@all = []

    def initialize(hash_of_data)
        @player_data = hash_of_data
        @@all.push(self)
    end


    def self.display_all_names_only
        @@all.each_with_index{|player, index| puts "#{index + 1}. #{player.player_data["Player"]}"}
    end

    def display_all_stats
        puts "Here is #{player_data["Team"]}'s stats:"
        player_data.each{|key, value|
            #added prettines
            case key.size
            when 1 
                puts "#{key}    : #{value}"
            when 2 
                puts "#{key}   : #{value}"
            when 3
                puts "#{key}  : #{value}"
            end
        }
    end

    def self.all 
        @@all 
    end

    def self.get_from_index(index)
        @@all[index -1]
    end

end