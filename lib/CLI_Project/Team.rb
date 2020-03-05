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

    /#returns an array of hashes. Each hash is a teams stat info
    def self.set_teams_from_scraped_data(index_url, class_name)
        scraped_teams = Scraper.scraper(index_url)

        team_index = 1
        scraped_teams.css("td").each_with_index{|team_info, index| 
            # 11 because there is 11 collums of information given one team
            if classname == Team
            if (11 * team_index + 1) == index && !team_info.text.include?("Pages") # last row is not team information
            else 
                if (19 * team_index + 1) == index && !team_info.text.include?("Pages")
         
                team_data = {}
                collum_index = 0
                data_index = (11 * (team_index - 1)) + 1
                11.times{
                    team_data[scraped_teams.css("th")[collum_index].text] = scraped_teams.css("td")[data_index].text
                    collum_index += 1
                    data_index += 1
                    
                }
                if number == 11 
                    Team.new(team_data)
                else 
                   Player(team_data)
                end
                
                team_index += 1
            end
        }
    end #/
end