class Player
    attr_reader :player_data, :name
    @@all = []

    def initialize(hash_of_data)
        @player_data = hash_of_data
        @name = hash_of_data["Player"]
        @@all.push(self)
    end


    def self.display_all_names_only
        @@all.each_with_index{|player, index| puts "#{index}. #{player.name}"}
    end

    def display_all_stats
        puts "Here is #{@name}'s stats:"
        player_data.each{|key, value| puts "#{key} : #{value}"}
    end

    def self.all 
        @@all 
    end

    def self.get_from_index(index)
        @@all[index]
    end


end