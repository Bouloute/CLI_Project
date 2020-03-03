class CLI_Project::Cli
    attr_reader :scraped_team
    def call
       # @scraped_team = Scraper.new("http://www.nhl.com/stats/teams")
       # @scraped_team = Scraper.new("https://www.cbssports.com/nhl/stats/teamsort/nhl/year-2019-season-regularseason-category-points")
       @scraped_team = Scraper.new("https://www.cbssports.com/nhl/stats/teamsort/sortableTable/nhl/year-2019-season-regularseason-category-points?print_rows=9999")
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
                player_menu
            when "help"
                menu_help
            end
        end
    end

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
        puts "Enter \"help\" for the list of instructions or enter \"exit\" to leave"
    end

    #menu for the team stats
    #returns nil or "exit" 
    def team_menu
        puts "Here is the list of the teams currently playing"
        

        team_index = 0
        @scraped_team.scrapped.css("td").each_with_index{|team_info, index| 
            if (11 * team_index + 1) == index && !team_info.text.include?("Pages")
                puts "#{team_index + 1}. #{team_info.text}"
                team_index += 1
            end
        }

        team_help

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
                menu_help
                return
            elsif user_input == "exit"
                #returns to the main menu to exit
                return user_input
            end
        end
    end

    def team_data(team_index)
        team_data = {}
        index = (11 * (team_index - 1)) + 1 
        team_data[:name] = @scraped_team.scrapped.css("td")[index].text
        team_data[:GP]   = @scraped_team.scrapped.css("td")[index + 1].text
        team_data[:PTS]  = @scraped_team.scrapped.css("td")[index + 2].text
        team_data[:G]    = @scraped_team.scrapped.css("td")[index + 3].text
        team_data[:GA]   = @scraped_team.scrapped.css("td")[index + 4].text
        team_data[:GAA]  = @scraped_team.scrapped.css("td")[index + 5].text
        team_data[:SOG]  = @scraped_team.scrapped.css("td")[index + 6].text
        team_data[:PCT]  = @scraped_team.scrapped.css("td")[index + 7].text
        team_data[:PPG]  = @scraped_team.scrapped.css("td")[index + 8].text
        team_data[:SHG]  = @scraped_team.scrapped.css("td")[index + 9].text
        team_data[:SHOG] = @scraped_team.scrapped.css("td")[index + 10].text

        puts "Here is #{team_data[:name]} team's stats:"
        puts "GP   : #{team_data[:GP]}"
        puts "PTS  : #{team_data[:PTS]}"
        puts "G    : #{team_data[:G]}"
        puts "GA   : #{team_data[:GA]}"
        puts "GAA  : #{team_data[:GAA]}"
        puts "SOG  : #{team_data[:SOG]}"
        puts "PCT  : #{team_data[:PCT]}"
        puts "PPG  : #{team_data[:PPG]}"
        puts "SHG  : #{team_data[:SHG]}"
        puts "SHOG : #{team_data[:SHOG]}"
    end

    def player_menu
        puts "Here is the list of the players currently playing"
    end
end