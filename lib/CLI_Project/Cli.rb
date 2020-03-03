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
        puts "Here you'll be able to see your favorite team or player's stats"
        help

        user_imput = nil
        while user_imput != "exit"
        user_imput = gets.chomp.downcase
            case user_imput
            when "1"
                team_stats
            when "2"
                player_stats
            when "help"
                help
            end
        end
    end

    def help 
        puts "Would you like to access:"
        puts "  1. Team Stats"
        puts "  2. Player Stats"
        puts "Enter the number, help for the list of instructions or enter \"exit\" to leave"
    end

    def team_stats
        puts "Here is the list of the teams currently playing"
        
        #binding.pry
        team_index = 0
        @scraped_team.scrapped.css("td").each_with_index{|team_info, index| 
            if (11 * team_index + 1) == index && !team_info.text.include?("Pages")
                puts "#{team_index + 1}. #{team_info.text}"
                team_index += 1
            end
        }
    end

    def player_stats
        puts "Here is the list of the players currently playing"
    end
end