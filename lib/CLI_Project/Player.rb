class Player
    attr_reader :player_data, :name
    @@all = []

    def initialize(hash_of_data)
        @player_data = hash_of_data
        @name = hash_of_data["Player"]
        @@all.push(self)
    end


    def self.display_all_names_only
        @@all.each_with_index{|player, index| puts "#{index + 1}. #{player.name}"}
    end

    def display_all_stats
        puts "Here is #{@name}'s stats:"
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

    /#returns an array of hashes. Each hash is a teams stat info
    def self.set_players_from_scraped_data(index_url)
        scraped_players = Scraper.scraper(index_url)

        player_index = 1
        scraped_players.css("td").each_with_index{|player_info, index| 
            # 19 because there is 19 collums of information given one player
            if (19 * player_index + 1) == index && !player_info.text.include?("Pages") # last row is not player information
         
                player_data = {}
                collum_index = 0
                data_index = (19 * (player_index - 1)) + 1
                19.times{
                    player_data[scraped_players.css("th")[collum_index].text] = scraped_players.css("td")[data_index].text
                    collum_index += 1
                    data_index += 1
                    
                }
                Player.new(player_data)
                
                player_index += 1
            end
        }
    end#/
end