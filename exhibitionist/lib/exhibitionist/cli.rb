class ExhibitionistCli
  attr_reader :museum, :id

  def initialize
    top_menu
  end

  def top_menu
    
    system("clear")
    puts "Hello. Which exhibits would you like me to fetch?\n\n"
    puts "1. Search by museum."
    # puts "2. Top exhibits open right now"
    # puts "3. All exhibits open right now"
    puts "And type q at any time to quit."
    input = gets.strip
      case input
      when "1"
        # puts "\nWe got the Brooklyn Museum, The Guggenheim and The Met right now. "
        # puts "(type Brooklyn, Guggenheim or Met)"
        # museum = gets.strip.downcase
        #   case museum
        #   when "brooklyn"
              fetching_message
              @raw = Scraper.scrape(URL[:bklyn], CSS[:bk][:main])
              @exh_array = Scraper.parse_bk(@raw)
  # binding.pry
              Museum.new(@exh_array, input, CSS[:bk]).display_exhibits
              # @museum.display_exhibits(@exhibits)
              detail_menu

              
            
            # sleep 2
            # top_menu

          # when "guggenheim"
          #   fetching_message
          #   doc = Scraper.scrape(URL[:gugg], CSS[:gugg][:main]).parse_gugg(@raw)
            # Museum.new(@gugg_array, museum, CSS[:gugg])
            # @museum.display_exhibits(@exhibits)
            # detail_menu
          # else
          #   huh?
          # end

          # when "met"
          #   fetching_message
              # input = Museum.new(Scraper.new.the_met, input)
              # input.display_exhibits(@exhibits)
          #   top_menu

          # end

      # when "2"
      #   under_construction

      # when "3"
      #   under_construction

      when "q"
        farewell

      else
        huh?
      end

  end


  def detail_menu
    puts "\n\nEnter a number to fetch a detailed description.\n\n"
    puts "Or:"
    puts "--m for the main menu"
    puts "--q to quit"
    input = gets.strip.downcase
# binding.pry
      case input.to_i
      when 0 
        if input == "m"
          top_menu
        elsif input == "q"
          farewell
        else
          huh?
        end
      else
        url = @museum.exhibits[input.to_i - 1].url
        ## Need to match this to the right detail scraper.
  # binding.pry
        # @museum.exhibits[input.to_i - 1].get_desc(url)
        # puts Scraper.brooklyn_exhibit(url)
        puts Nokogiri::HTML(open(url)).css(".exhibition-description").text.gsub(/\s{2,10}/, "\n\n")
  # binding.pry
        go_back         
      end
  end

  def go_back
    puts "\n\nWhat now?"
    puts "--b to go back to the list"
    puts "--m for main menue"
    puts "--q to quit"
    what_now = gets.strip.downcase
      case what_now 
      when "b"
        @museum.display_exhibits(@exhibits)
        detail_menu
      when "m"
        top_menu
      when "q"
        farewell
      else
        huh?
        go_back
      end

  end


  def fetching_message
    puts "\nGetting your exhibits now. This might take a second.\n"
  end

  def huh?
    puts "I didn't get that. Let's try again"
    sleep 1
    system("clear")
    top_menu
  end

  def farewell
    system("clear")
    puts "Fine. Go watch TV or get drunk, you philistine.\n\n"
    # sleep 1
  end

  def under_construction
    puts "Art takes time and this feature ain't built yet."
    puts "But if yer in a hurry for some art, type 'now'"
    now = gets.strip.downcase
      if now == "now"
        %x`open -a Safari http://www.dogsplayingpoker.org/gallery/coolidge/img/a_friend_in_need.jpg`
      else
        puts "Okay, check back later."
        sleep 1
        top_menu
      end
  end



end



=begin

1) welcomes user, calls first menu
2) takes input of museum name and: 
  --calls that scraper
  --Instantiates Museum, which builds exhibits
  --displays events for that museum
  --calls details sub-menu
3) add "top events" option
  --calls each scraper but adds .first

3) needs sub-menus:
  --



=end