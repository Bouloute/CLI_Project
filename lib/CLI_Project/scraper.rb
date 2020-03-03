class Scraper
   # attr_reader :scrapped 

    def initialize()#path)
        #@scrapped = scraper(path)

    end

    def self.scraper(index_url)
        students = []
        Nokogiri::HTML(open(index_url))
    end 

    #returns an array of hashes. Each hash is a teams stat info
    def self.teams(index_url)
        scraped_teams = scraper(index_url)

        #puts "Here is the list of the teams currently playing this season, in order of the most points"
        teams =[]

        team_index = 1
        scraped_teams.css("td").each_with_index{|team_info, index| 
            # 11 because there is 11 collums of information given one team
            if (11 * team_index + 1) == index && !team_info.text.include?("Pages") # last row is not team information
         
                team_data = {}
                collum_index = 0
                data_index = (11 * (team_index - 1)) + 1
                11.times{
                    team_data[scraped_teams.css("th")[collum_index].text] = scraped_teams.css("td")[data_index].text
                    collum_index += 1
                    data_index += 1
                    
                }
                teams.push(team_data)
                
                team_index += 1
            end
            
        }

        teams
    end


    #returns an array of hashes. Each hash is a teams stat info
    def self.players(index_url)
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