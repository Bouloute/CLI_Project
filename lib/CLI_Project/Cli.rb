class CLI_Project::Cli
    attr_reader :teams#:scraped_teams, :scrapped_players
    def call
       # @scraped_team = Scraper.new("http://www.nhl.com/stats/teams")
       # @scraped_team = Scraper.new("https://www.cbssports.com/nhl/stats/teamsort/nhl/year-2019-season-regularseason-category-points")
       
       
       # Set up
        set_all_teams
        set_all_players
        
        #@scraped_players = Scraper.new("https://www.cbssports.com/nhl/stats/playersort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
        main_menu
    end

    #-----------------------------SET UP-----------------------------
    
    #Creates each team
    def set_all_teams
        aoh_team_data = Scraper.teams("https://www.cbssports.com/nhl/stats/teamsort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
        aoh_team_data.each{|team| Team.new(team)}
    end

    #Creates each team
    def set_all_players
        aoh_player_data = Scraper.players("https://www.cbssports.com/nhl/stats/playersort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
        aoh_player_data.each{|player| Player.new(player)}
    end

    #----------------------------------------------------------------



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

    
    #---------------------------CLI----------------------------------
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

    #menu for the team stats
    def team_menu
        #displays teams
        Team.display_all_names_only
        #shows possible commands
        team_help

        #collects command
        while 
        user_input = gets.chomp.downcase
        #I would've rather used a case
        #How to use case to check if number or string???
            if user_input.to_i != 0 && user_input.to_i <= Team.all.size
                team_asked = Team.get_from_index(user_input.to_i)
                team_asked.display_all_stats

            elsif user_input == "help"
                team_help
            elsif user_input == "back"
                #returning to the main menu
                menu_help
                return
            elsif user_input == "exit"
                #returns to the main menu to exit
                return user_input
            end
        end
    end
    
   
    #menu for the player stats
    #returns nil or "exit" 
    def player_menu
        #displays players
        Player.display_all_names_only
        #shows possible commands
        player_help

        #collects command
        while 
        user_input = gets.chomp.downcase
        #I would've rather used a case
        #How to use case to check if number or string???
            if user_input.to_i != 0 && user_input.to_i <= Player.all.size
                player_asked = Player.get_from_index(user_input.to_i)
                player_asked.display_all_stats

            elsif user_input == "help"
                player_help
            elsif user_input == "back"
                #returning to the main menu
                menu_help
                return
            elsif user_input == "exit"
                #returns to the main menu to exit
                return user_input
            end
        end
    end


    
    #----------------------------------------------------------------

    
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