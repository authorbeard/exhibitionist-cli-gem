class ExhibitionistCli
  attr_reader :museum

  def initialize
    top_menu
  end

  def top_menu
    
    system("clear")
    puts "Hello. Which exhibits would you like me to fetch?\n\n"
    puts "1. test the Brooklyn method."
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
            @museum = Museum.new(Scraper.new.bklyn, input)
            @museum.display_exhibits(@exhibits)
            detail_menu

              
            
            # sleep 2
            # top_menu

          # when "guggenheim"
          #   fetching_message
          #   input = Museum.new(Scraper.new.gugg, input)
            # input.display_exhibits(@exhibits)
              # top_menu

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
        url = @museum.exhibits[input.to_i - 1][:url] 
        ## Need to match this to the right detail scraper.
        puts Nokogiri::HTML(open(url)).css(".exhibition-description").text.gsub(/\s{2,10}/, "\n\n")
         
# binding.pry
        puts "Now I'll take #{input} and use it to call on a url."
      end
    # at present, Exhibit.list_all just displays a hash of strings.
    # but the input here should be able to refer to an exhibit in the Exhibit
    # @@all array, grab that url, and feed it to the detail scraper
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