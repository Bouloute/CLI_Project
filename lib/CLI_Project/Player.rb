class Player
    extend Scraper
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
        player_data.each{|key, value| puts "#{key} : #{value}"}
    end

    def self.all 
        @@all 
    end

    def self.get_from_index(index)
        @@all[index -1]
    end


    #returns an array of hashes. Each hash is a teams stat info
    def self.set_players_from_scraped_data(index_url)
        scraped_players = scraper(index_url)

        #puts "Here is the list of the players currently playing this season, in order of the most points"
        players =[]

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
                players.push(player_data)
                
                player_index += 1
            end
            
        }

        players
    end

end