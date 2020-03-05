class Team
    attr_reader :team_data, :name
    @@all = []

    def initialize(hash_of_data)
        @team_data = hash_of_data
        @name = hash_of_data["Team"]
        @@all.push(self)
    end


    def self.display_all_names_only
        @@all.each_with_index{|team, index| puts "#{index + 1}. #{team.name}"}
    end

    def display_all_stats
        puts "Here is #{@name}'s stats:"
        team_data.each{|key, value| 
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
        @@all[index - 1]
    end

end