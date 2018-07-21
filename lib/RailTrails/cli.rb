class RailTrails::Cli
attr_accessor :name

  def initialize(name)
    @name = name
  end

  def welcome
    puts "Welcome to #{self.name}!"
    puts "This app will help you find a rail trail near you."
    main_menu
  end

  def main_menu
    RailTrails::RailTrail.all.clear
    puts "Please enter a five-digit zip code"
    puts "Type exit to exit the program"
    input = gets.strip
    if input =~ /\A[0-9]{5}\z/
      list_railtrails(input)
    elsif input.downcase == "exit"
      puts "Happy Trails! Please consider making a donation to www.railstotrails.org"
    else
      try_again
      main_menu
    end
  end
  
  def list_railtrails(input)
    puts "Here is a list of railtrails near you:"
    RailTrails::Scraper.new("https://www.traillink.com/trailsearch/?mmloc=" + input).scrape
    trail_list
    puts "Enter the trail number to get more details"
    trail_number = gets.strip.to_i
    if !(trail_number > 0 && trail_number <= RailTrails::RailTrail.all.length)
      try_again
      main_menu
    else #if trail_number <= RailTrails::RailTrail.all.length
      trail = RailTrails::RailTrail.all[trail_number - 1]
      RailTrails::Scraper.scrape_details(trail)
      display_trail(trail)
    end
  end

  def trail_list
    RailTrails::RailTrail.all.each.with_index(1) do |trail, index|
      puts "#{index}. #{trail.name} - #{trail.length}"
    end
  end

  def display_trail(trail)
    puts "Here are the #{trail.name} details:\n
    Length: #{trail.length}, State(s): #{trail.states}, Surface: #{trail.surface}\n
    Endpoints: #{trail.endpoints}\n
    Description: #{trail.description}"
  end

  def try_again
    puts "Hmmm...try again."
  end

end