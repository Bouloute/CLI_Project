class CLI_Project::Cli
    attr_reader :scraped_teams, :scrapped_players
    def call
       # @scraped_team = Scraper.new("http://www.nhl.com/stats/teams")
       # @scraped_team = Scraper.new("https://www.cbssports.com/nhl/stats/teamsort/nhl/year-2019-season-regularseason-category-points")
        @scraped_teams = Scraper.new("https://www.cbssports.com/nhl/stats/teamsort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
        @scraped_players = Scraper.new("https://www.cbssports.com/nhl/stats/playersort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
        main_menu
    end

    def main_menu
        puts "Welcome to NHL_Stats"
        puts "Here you will be able to see your favorite team or player's statistics from CBS Sports."
        menu_help

        user_input = nil
        while user_input != "exit"
            user_input = gets.chomp.downcase
            case user_input
            when "1"
                user_input = team_menu #user_input == "exit" or nil
            when "2"
                user_input = player_menu #user_input == "exit" or nil
            when "help"
                menu_help
            end
        end
    end

    #----------------------COMMAND INSTRUCTIONS----------------------
    #shows the list of commands on the main menu
    def menu_help 
        puts "Would you like to access:"
        puts "  1. Team Stats"
        puts "  2. Player Stats"
        puts "Enter the number, \"help\" for the list of instructions or \"exit\" to leave"
    end

    #shows the list of commands on the team menu
    def team_help 
        puts "Enter the number of the team you would like more information about"
        puts "Enter \"help\" for the list of instructions or \"exit\" to leave"
    end
  
    #shows the list of commands on the player menu
    def player_help 
        puts "Enter the number of the player you would like more information about"
        puts "Enter \"help\" for the list of instructions or \"exit\" to leave"
    end
    #----------------------------------------------------------------

    #menu for the team stats
    #returns nil or "exit" 
    def team_menu
        puts "Here is the list of the teams currently playing this season, in order of the most points"
        
        #puts the teams
        team_index = 0
        @scraped_teams.scrapped.css("td").each_with_index{|team_info, index| 
            # 11 because there is 11 collums of information given one team
            if (11 * team_index + 1) == index && !team_info.text.include?("Pages") # last row is not team information
                puts "#{team_index + 1}. #{team_info.text}"
                team_index += 1
            end
        }

        #shows possible commands
        team_help

        #collects command
        while 
        user_input = gets.chomp.downcase
        #I would've rather used a case
        #How to use case to check if number or string???
            if user_input.to_i != 0 && user_input.to_i <= team_index
                team_data(user_input.to_i)
            elsif user_input == "help"
                team_help
            elsif user_input == "back"
                #returning to the main menu
                team_help
                return
            elsif user_input == "exit"
                #returns to the main menu to exit
                return user_input
            end
        end
    end

    #collects data from the scrapped page
    #puts that data
    def team_data(team_index)
        team_data = {}
         
        # There is 11 stats per team
        collum_index = 0
        data_index = (11 * (team_index - 1)) + 1
        11.times{
            team_data[@scraped_teams.scrapped.css("th")[collum_index].text] = @scraped_teams.scrapped.css("td")[data_index].text
            collum_index += 1
            data_index += 1
        }

        puts "Here is #{team_data["Team"]} team's stats:"
        team_data.each{|key, value| puts "#{key} : #{value}"}
    end

    #menu for the player stats
    #returns nil or "exit" 
    def player_menu
        puts "Here is the list of the players currently playing in order or most points"

        #puts the players
        player_index = 0
        @scraped_players.scrapped.css("td").each_with_index{|player_info, index| 
            #19 because there is 19 different collums of information given one player
            if (19 * player_index + 1) == index && !player_info.text.include?("Pages") #last row is not player information
                puts "#{player_index + 1}. #{player_info.text}"
                player_index += 1
            end
        }

        #shows possible commands
        player_help

        #collects command
        while 
        user_input = gets.chomp.downcase
        #I would've rather used a case
        #How to use case to check if number or string???
            if user_input.to_i != 0 && user_input.to_i <= player_index
                player_data(user_input.to_i)
            elsif user_input == "help"
                player_help
            elsif user_input == "back"
                #returning to the main menu
                player_help
                return
            elsif user_input == "exit"
                #returns to the main menu to exit
                return user_input
            end
        end
    end

    #collects data from the scrapped page
    #puts that data
    def player_data(player_index)
        player_data = {}
         
        # There is 19 stats per player
        collum_index = 0
        data_index = (19 * (player_index - 1)) + 1
        19.times{
            player_data[@scraped_players.scrapped.css("th")[collum_index].text] = @scraped_players.scrapped.css("td")[data_index].text
            collum_index += 1
            data_index += 1
        }

        puts "Here is #{player_data["Player"]} player's stats:"
        player_data.each{|key, value| puts "#{key} : #{value}"}
    end
end