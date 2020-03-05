class CLI_Project::Cli
    attr_reader :teams
    def call    
       # Set up
        set_all_teams
        set_all_players
        set_all_games

        main_menu
    end

    #-----------------------------SET UP-----------------------------
    
    #Creates each team
    def set_all_teams
        Scraper.set_from_scraped_data("https://www.cbssports.com/nhl/stats/teamsort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999", "team")
    end

    #Creates each player
    def set_all_players
        Scraper.set_from_scraped_data("https://www.cbssports.com/nhl/stats/playersort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999","player")
    end

    #Creates each game
    def set_all_games
        Scraper.set_games_from_scraped_data("https://www.cbssports.com/nhl/schedule/")
    end
    #----------------------------------------------------------------



    #----------------------COMMAND INSTRUCTIONS----------------------
    #shows the list of commands on the main menu
    def menu_help 
        puts "Would you like to access:"
        puts "  1. Team Stats"
        puts "  2. Player Stats"
        puts "  3. Today's Games"
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

    #shows the list of commands on the game menu
    def game_help 
        puts "Enter \"help\" for the list of instructions"
        puts "Enter \"back\" to return to the main menu"
        puts "Enter \"exit\" to leave"
    end
    #----------------------------------------------------------------

    
    #---------------------------CLI----------------------------------
    def main_menu
        puts "Welcome to NHL Stats"
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
            when "3", "game", "today's game"
                user_input = game_menu #user_input == "exit" or nil
            when "help"
                menu_help
            end
        end
    end

    #menu for the team stats
    #returns nil or "exit" 
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
    

    #Shows game playing today
    def game_menu
        #displays games
        Game.display_team_names_only
        #shows possible commands
        game_help

        user_input = nil
        while user_input != "exit"
            user_input = gets.chomp.downcase
            case user_input
            when "help"
                game_help
            when "back"
                menu_help
                return "back"
            when "exit"
                return "exit"
            end
        end
    end    
    #----------------------------------------------------------------

end