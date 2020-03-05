class CLI_Project::Cli
    attr_reader :teams#:scraped_teams, :scrapped_players
    def call    
       # Set up
        set_all_teams
        set_all_players
        
        main_menu
    end

    #-----------------------------SET UP-----------------------------
    
    #Creates each team
    def set_all_teams
        Team.set_teams_from_scraped_data("https://www.cbssports.com/nhl/stats/teamsort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
    end

    #Creates each player
    def set_all_players
        Player.set_players_from_scraped_data("https://www.cbssports.com/nhl/stats/playersort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
    end

    #----------------------------------------------------------------



    #----------------------COMMAND INSTRUCTIONS----------------------
    #shows the list of commands on the main menu
    def menu_help 
        puts "Would you like to access:"
        puts "  1. Team Stats"
        puts "  2. Player Stats"
        puts "Enter the number"
        puts "Enter \"help\" for the list of instructions"
        puts "Enter \"exit\" to leave"
    end

    #shows the list of commands on the team menu
    def team_help 
        puts "Enter the number of the team you would like more information about"
        puts "Enter \"help\" for the list of instructions"
        puts "Enter \"back\" to return to the main menu"
        puts "Enter \"exit\" to leave"
    end
  
    #shows the list of commands on the player menu
    def player_help 
        puts "Enter the number of the player you would like more information about"
        puts "Enter \"help\" for the list of instructions"
        puts "Enter \"back\" to return to the main menu"
        puts "Enter \"exit\" to leave"
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
            when "1", "team", "team stats"
                user_input = team_menu #user_input == "exit" or nil
            when "2", "player", "player stats"
                user_input = player_menu #user_input == "exit" or nil
            when "help"
                menu_help
            end
        end
    end

    #menu for the team stats
    def team_menu
        #displays teams name
        Team.display_all_names_only

        #shows possible commands
        team_help

        #collects command
        while 
        user_input = gets.chomp.downcase
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

end